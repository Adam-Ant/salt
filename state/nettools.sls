include:
- apt

install_network_packages:
  pkg.installed:
    - pkgs:
       - curl
       - vim
    - require:
      - sls: apt

