{
  buildGoModule,
  deno,
  fetchFromGitHub,
  lib,
  git,
  stdenv,
}:

buildGoModule rec {
  pname = "silverbullet";
  version = "2.4.1";

  src = fetchFromGitHub {
    owner = "silverbulletmd";
    repo = "silverbullet";
    rev = version;
    hash = "sha256-AjaD3KwHYHj+vkW8E2jr9BjhP+HCWSMwKklSNmAuaLE=";
  };

  vendorHash = "sha256-R/jjUWLCAmhSJUSi91+iWxHqRcxq6mpz5rvz+5PFV2A=";

  nativeBuildInputs = [
    deno
    git
  ];

  preBuild = ''
    export HOME=$TMPDIR
    export DENO_DIR=$TMPDIR/.deno

    # Build the frontend with deno (production build)
    deno task build-production
  '';

    tests = {
      inherit (nixosTests) silverbullet;
    };
  };

  meta = {
    changelog = "https://github.com/silverbulletmd/silverbullet/blob/${version}/CHANGELOG.md";
    description = "Open-source, self-hosted, offline-capable Personal Knowledge Management (PKM) web application";
    homepage = "https://silverbullet.md";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ aorith ];
    mainProgram = "silverbullet";
  };
}
