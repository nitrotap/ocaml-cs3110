type instruction = { prompt_title : string; prompt : string }

let rec ask_for_field prompt =
  Printf.printf "%s (Y/n): " prompt;
  match String.lowercase_ascii (read_line ()) with
  | "y" | "" -> true
  | "n" -> false
  | _ ->
      Printf.printf "Please enter 'y' or 'n'.\n";
      ask_for_field prompt

let generate_markdown inputs toc =
  let toc_content =
    if toc <> [] then
      "## Table of Contents \n\n"
      ^ List.fold_left
          (fun acc item ->
            acc ^ "- [" ^ item ^ "](#" ^ String.lowercase_ascii item ^ ")\n")
          "" (List.rev toc)
      ^ "\n\n"
    else ""
  in

  List.fold_left
    (fun acc (title, content) ->
      match title with
      | "Title" -> acc ^ "# " ^ content ^ "\n\n"
      | "Description" ->
          acc ^ "## " ^ title ^ "\n\n" ^ content ^ "\n\n" ^ toc_content
      | _ -> acc ^ "## " ^ title ^ "\n\n" ^ content ^ "\n\n")
    "" inputs

let get_input instructions =
  List.fold_left
    (fun (acc, toc) { prompt_title; prompt } ->
      match prompt_title with
      | "Title" | "Description" ->
          Printf.printf "%s: " prompt;
          let user_input = read_line () in
          Printf.printf "%s: %s\n" prompt_title user_input;
          ((prompt_title, user_input) :: acc, toc)
      | _ ->
          let question = "Would you like to include " ^ prompt_title ^ "?" in
          if ask_for_field question then (
            let () = Printf.printf "%s: " prompt in
            let user_input = read_line () in
            Printf.printf "%s: %s\n" prompt_title user_input;
            ((prompt_title, user_input) :: acc, prompt_title :: toc))
          else (acc, toc))
    ([], []) instructions

let make_instruction prompt_title prompt = { prompt_title; prompt }
let make_prompt prompt_title = "Enter " ^ prompt_title

let titles =
  [
    "Title";
    "Description";
    "Installation-Instructions";
    "Usage-Instructions";
    "License";
    "Author";
  ]

let instructions =
  List.map (fun title -> make_instruction title (make_prompt title)) titles

let write_file content =
  let oc = open_out "README-output.md" in
  output_string oc content;
  close_out oc

let () =
  let inputs, toc = get_input instructions in
  let markdown = generate_markdown (List.rev inputs) toc in
  write_file markdown;
  Printf.printf "README-output.md has been generated.\n"
