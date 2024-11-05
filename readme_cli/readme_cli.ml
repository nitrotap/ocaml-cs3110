open Cmdliner

let () = print_endline "Hello, World!"

let generate_readme title description =
  let content = Printf.sprintf "# %s\n\n%s\n" title description in
  let oc = open_out "README.md" in
  Printf.fprintf oc "%s" content;
  close_out oc;
  Printf.printf "README.md created with title '%s\n" title

  let title_arg =
    let doc = "title of readme file" in
    Arg.(required & pos 0 (some string) None & info [] ~docv: "TITLE" ~doc)

  let description_arg =
    let doc = "Description of the project" in
    Arg.(value & opt string "" & info ["d"; "description"] ~docv:"DESCRIPTION" ~doc)

  let cmd =
    let doc = "Generate a GitHub README file" in
    let info = Cmd.info "readme_cli" ~doc in
    Cmd.v info Term.(const generate_readme $ title_arg $ description_arg)

  let () =
  exit (Cmd.eval cmd)

