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
        rust = {
          path = ./rust;
          description = "Rust flake";
        };
        odin = {
          path = ./odin;
          description = "Odin flake";
        };
        java = {
          path = ./java;
          description = "Java flake";
        };
        dotnet = {
          path = ./dotnet;
          description = "Dotnet flake";
        };
        php = {
          path = ./php;
          description = "PHP flake";
        };
        laravel = {
          path = ./laravel;
          description = "Laravel flake";
        };
      };
    };
}
