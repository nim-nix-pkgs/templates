{
  description = ''a compile-time templating engine for nim'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-templates-master.flake = false;
  inputs.src-templates-master.ref   = "refs/heads/master";
  inputs.src-templates-master.owner = "onionhammer";
  inputs.src-templates-master.repo  = "nim-templates.git";
  inputs.src-templates-master.type  = "github";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-templates-master"];
  in lib.mkRefOutput {
    inherit self nixpkgs ;
    src  = deps."src-templates-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  };
}