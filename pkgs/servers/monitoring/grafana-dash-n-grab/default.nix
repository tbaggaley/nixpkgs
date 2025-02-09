{ buildGoModule, fetchFromGitHub, lib }:

buildGoModule rec {
  pname = "grafana-dash-n-grab";
  version = "0.4.3";

  src = fetchFromGitHub {
    rev = "v${version}";
    owner = "esnet";
    repo = "gdg";
    sha256 = "sha256-L7EFDLCbXp8ooQY9QxbfT0ooL1oC+z8LwpEvH4CvivE=";
  };

  vendorHash = "sha256-7K2NTpknzJvKOfJ4gruV99BIvgtGgsre8ybqWTQ09tQ=";

  ldflags = [
    "-s"
    "-w"
    "-X main.Version=${version}"
    "-X github.com/esnet/gdg/version.GitCommit=${src.rev}"
  ];

  # The test suite tries to communicate with a running version of grafana locally. This fails if
  # you don't have grafana running.
  doCheck = false;

  meta = with lib; {
    description = "Grafana Dash-n-Grab (gdg) -- backup and restore Grafana dashboards, datasources, and other entities";
    license = licenses.bsd3;
    homepage = "https://github.com/esnet/gdg";
    maintainers = with maintainers; teams.bitnomial.members;
    platforms = platforms.unix;
    mainProgram = "gdg";
    changelog =
      "https://github.com/esnet/gdg/releases/tag/v${version}";
  };
}
