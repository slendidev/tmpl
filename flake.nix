{
  description = "A collection of flake templates";

  outputs =
    { self }:
    {
      templates = {
        simple = {
          path = ./simple;
          description = "Basic flake";
        };
        c_cpp = {
          path = ./c_cpp;
          description = "C/C++ flake";
        };
        python = {
          path = ./python;
          description = "Python flake";
        };
      };
    };
}
