;;; magit-subtree.el --- subtree support for Magit  -*- lexical-binding: t -*-

;; Copyright (C) 2011-2015  The Magit Project Contributors
;;
;; You should have received a copy of the AUTHORS.md file which
;; lists all contributors.  If not, see http://magit.vc/authors.

;; Author: Jonas Bernoulli <jonas@bernoul.li>
;; Maintainer: Jonas Bernoulli <jonas@bernoul.li>

;; Magit is free software; you can redistribute it and/or modify it
;; under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; Magit is distributed in the hope that it will be useful, but WITHOUT
;; ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
;; or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
;; License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with Magit.  If not, see http://www.gnu.org/licenses.

;;; Code:

(require 'magit)

;;;###autoload (autoload 'magit-subtree-popup "magit-subtree" nil t)
(magit-define-popup magit-subtree-popup
  "Popup console for subtree commands."
  'magit-commands
  :man-page "git-subtree"
  :switches '("Switches for add, merge, push, and pull"
              (?s "Squash" "--squash")
              "Switches for split"
              (?i "Ignore joins" "--ignore-joins")
              (?j "Rejoin"       "--rejoin"))
  :options  '("Options"
              (?p "Prefix" "--prefix=" magit-subtree-read-prefix)
              "Options for add, merge, and pull"
              (?m "Message" "--message=")
              "Options for split"
              (?a "Annotate" "--annotate=")
              (?b "Branch"   "--branch=")
              (?o "Onto"     "--onto=" magit-read-branch-or-commit))
  :actions  '((?a "Add"        magit-subtree-add)
              (?m "Merge"      magit-subtree-merge)
              (?p "Push"       magit-subtree-push)
              (?c "Add commit" magit-subtree-add)
              (?f "Pull"       magit-subtree-pull)
              (?s "Split"      magit-subtree-split))
  :max-action-columns 3)

(defun magit-git-subtree (prefix args)
  (magit-run-git "subtree" "-P" prefix args))

(defun magit-subtree-read-prefix (prompt)
  )

(defun magit-subtree-read-arguments (prompt)
  )

;;;###autoload
(defun magit-subtree-add (prefix repository commit args)
  "Add COMMIT from REPOSITORY as a new subtree at PREFIX."
  (interactive (magit-subtree-read-arguments))
  (magit-git-subtree "add" "-P" prefix args repository commit))

;;;###autoload
(defun magit-subtree-add-commit (prefix commit args)
  "Add COMMIT as a new subtree at PREFIX."
  (interactive (magit-subtree-read-arguments))
  (magit-git-subtree "add" "-P" prefix args commit))

;;;###autoload
(defun magit-subtree-merge (prefix commit args)
  "Merge COMMIT into the PREFIX subtree."
  (interactive (magit-subtree-read-arguments))
  (magit-git-subtree "merge" "-P" prefix args commit))

;;;###autoload
(defun magit-subtree-pull (prefix repository commit args)
  "Pull COMMIT from REPOSITORY into the PREFIX subtree."
  (interactive (magit-subtree-read-arguments))
  (magit-git-subtree "pull" "-P" prefix args repository commit))

;;;###autoload
(defun magit-subtree-push (prefix repository ref args)
  "Extract the history of the subtree PREFIX and push it to REF on REPOSITORY."
  (interactive (magit-subtree-read-arguments))
  (magit-git-subtree "push" "-P" prefix args repository ref))

;;;###autoload
(defun magit-subtree-split (prefix commit args)
  "Extract the history of the subtree PREFIX."
  (interactive (magit-subtree-read-arguments))
  (magit-git-subtree "split" "-P" prefix args commit))

;;; magit-subtree.el ends soon
(provide 'magit-subtree)
;; Local Variables:
;; indent-tabs-mode: nil
;; End:
;;; magit-subtree.el ends here
