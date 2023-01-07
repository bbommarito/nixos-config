{ config, ... }:

{
  accounts.email =
    {
      accounts = 
        { 
          brianbommaritoxyz = rec 
            {
              address = "brian@brianbommarito.xyz";

              folders =
                {
                  inbox = "Inbox";
                  drafts = "Drafts";
                  sent = "Sent";
                  trash = "Trash";
                };

              imap.host = "imap.fastmail.com";

              mbsync =
                {
                  create = "maildir";
                  enable = true;
                  expunge = "both";
                };

              msmtp =
                {
                  enable = true;
                };

              neomutt =
                {

                  enable = true;
                  extraMailboxes =
                    [
                      "Archive"
                      "Drafts"
                      "Sent"
                      "Spam"
                      "Trash"
                    ];
                };

              passwordCommand = "${config.programs.password-store.package}/bin/pass ${smtp.host}/${address}";
              primary = true;
              realName = "Brian 'Burrito' Bommarito";
              smtp.host = "smtp.fastmail.com";
              userName = "brian@brianbommarito.xyz";
            };
        };
    };
}
