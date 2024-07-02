{...}: {
  home.sessionVariables = {
    BROWSER = "chromium";
  };

  programs.chromium = {
    enable = true;
    extensions = [
      {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # uBlock Origin
      {id = "iplffkdpngmdjhlpjmppncnlhomiipha";} # Unpaywall
      {id = "ldpochfccmkkmhdbclfhpagapcfdljkj";} # Decentraleyes
      {id = "pkehgijcmpdhfbdbbnkijodmdjhbjlgp";} # Privacy Badger
      {id = "ghmbeldphafepmbegfdlkpapadhbakde";} # Proton Pass
    ];
  };
}
