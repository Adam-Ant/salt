# https://jpetazzo.github.io/2013/10/06/policy-rc-d-do-not-start-services-automatically/
/usr/sbin/policy-rc.d:
  file.managed:
    - contents: exit 101
    - mode: 0755

/etc/apt/apt.conf.d/02-recommends.conf:
  file.managed:
    - contents: |
        APT::Get::Install-Recommends "false";
        APT::Get::Install-Suggests "false";
