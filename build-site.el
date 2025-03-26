;; Set the package installation directory so that packages aren't stored in the ~/.emacs.d/elpa path.
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

;; Custom HTML export
(setq org-html-validation-link nil            ;; Don't show validation link
      org-html-head-include-scripts nil       ;; Use our own scripts
      org-html-head-include-default-style nil ;; Use our own styles
      org-html-head 
      "<link rel=\"stylesheet\" type=\"text/css\" href=\"solarized.css\" />
       <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">
       <script>
         function toggleTOC() {
           var toc = document.getElementById('table-of-contents');
           var content = document.getElementById('content');
           toc.classList.toggle('hidden');
           content.classList.toggle('full-width');
         }
       </script>")

;; Additional HTML export options
(setq org-html-metadata-timestamp-format "%Y-%m-%d")
(setq org-html-htmlize-output-type 'css)

;; Define the publishing project
(setq org-publish-project-alist
      (list
       (list "org-site:main"
             :recursive t
             :base-directory "./content"
             :publishing-function 'org-html-publish-to-html
             :publishing-directory "./public"
             :with-author nil           ;; Don't include author name
             :with-creator t            ;; Include Emacs and Org versions in footer
             :with-toc t                ;; Include a table of contents
             :section-numbers nil       ;; Don't include section numbers
             :time-stamp-file nil)
       
       (list "org-static"
             :base-directory "./content"
             :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf\\|ico"
             :publishing-directory "./public"
             :recursive t
             :publishing-function 'org-publish-attachment)
       ))

;; Generate the site output
(org-publish-all t)

(message "Build complete!")
