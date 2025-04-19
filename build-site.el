;; Set the package installation directory
(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

;; Initialize the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;; Load the publishing system
(require 'ox-publish)

;; Custom HTML export settings
(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head 
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"solarized.css\" />
       <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">")

;; Configure HTML output
(setq org-html-metadata-timestamp-format "%Y-%m-%d"
      org-html-htmlize-output-type 'css
      org-html-divs '((preamble "header" "preamble")
                      (content "main" "content")
                      (postamble "footer" "postamble")))

;; Define the publishing project
(setq org-publish-project-alist
      `(("org-site:main"
         :recursive t
         :base-directory "./content"
         :publishing-function org-html-publish-to-html
         :publishing-directory "./public"
         :with-author nil
         :with-creator t
         :with-toc nil                ;; Disable table of contents
         :section-numbers nil
         :time-stamp-file nil
         :html-doctype "html5"
         :html-container "section"
         :html-html5-fancy t
         :html-preamble "<header class='page-header'></header>"
         :html-postamble "<footer class='page-footer'></footer>")
        
        ("org-static"
         :base-directory "./content"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|ico"
         :publishing-directory "./public"
         :recursive t
         :publishing-function org-publish-attachment)))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
