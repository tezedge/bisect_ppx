open OUnit2
open Test_helpers

let tests = "top-level" >::: [
  test "batch" (fun () ->
    compile
      ((with_bisect ()) ^ " -dsource")
      "fixtures/top-level/source.ml" ~r:"2> output";
    diff_ast "fixtures/top-level/batch.reference");

  test "stdin" (fun () ->
    skip_if (compiler () = "ocamlopt") "Top-level accepts only bytecode";
    run ("cat ../fixtures/top-level/source.ml | ocaml " ^
         "-ppx '../../../install/default/lib/bisect_ppx/ppx.exe --as-ppx' " ^
         "-stdin > /dev/null");
    run "! ls bisect0001.out 2> /dev/null")
]
