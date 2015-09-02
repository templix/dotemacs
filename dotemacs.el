;;                   __  _ __ ___   __ _  ___ ___
;;                  / _ \ '_ ` _ \ / _` |/ __/ __|
;;                 |  __/ | | | | | (_| | (__\__ \
;;                (_)___|_| |_| |_|\__,_|\___|___/
;;                               .-.
;; =--------------------------   /v\  ----------------------------=
;; = lapipaplena.org            // \\              templix@gmx.es =
;; =-----------------          /(   )\        --------------------=
;; =                            ^^-^^                             =
;; =         https://tractatuslapipaplena.herokuapp.com/          =
;; =--------------------------------------------------------------=
;
;
;;;;;;;;;;;;;;;;;;; Ajustes generales;;;;;;;;;;;;;;;;;;;;;;;;;;
;
;;; Si no queremos que muestre los errores del directorio de extensiones, si faltan algunas:
;(defadvice display-warning
;    (around no-warn-.emacs.d-in-load-path (type message &rest unused) activate)
;   "Ignorar advertencias sobre extensiones que faltan en el directorio .emacs.d"
;    (unless (and (eq type 'initialization)
; 	   (string-prefix-p "Your `load-path' seems to contain\nyour `.emacs.d' directory"
;            message t))))
;
;;; Algunqs cosas que podemos implementar en el arranque:
;(split-window-horizontally)   ;; Iniciar con la ventana dividida es dos
;(other-window 1)              ;; Moverse al segundo panel
;(shell)                       ;; Lanzar una shell
;(rename-buffer "shell-1")     ;; Enumerarla como "shell-1"
;(other-window 1)              ;; Ir nuevamente al primer panel
;
;; Sin mensaje de bienvenida:
(setq inhibit-startup-message t)
;
;; Sin mensaje en el buffer scratch:
; initial-scratch-message nil
;
;;; package.el (emacs24)
;;; (http://repo.or.cz/w/emacs.git/blob_plain/1a0a666f941c99882093d7bd08ced15033bc3f0c:/lisp/emacs-lisp/package.el)
;;; Paquetes listos para instalar (tipo apt-get). M-x package-list-packages (update) M-x list-packages (listar)
;;; Para activar el modo: M-x package-menu-mode
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))
(require 'cl)
;
(defvar my-packages
; Listado de paquetes con C-h v package-activated-list
  '(anti-zenburn-theme
    async
    auctex
    auto-complete
    auto-complete-auctex
    center-text
    chess
    color-theme
    color-theme-buffer-local
    browser-at-remote
    dash
    dired-details
    elfeed
    elfeed-web
    emms
    ss
    git-commit
    gntp
    google-this
    ;guru-mode
    hc-zenburn-theme
    hide-comnt
    hide-region
    htmlize
    httpd
    hydra
    insert-shebang
    latex-extra
    latex-preview-pane
    magit
    magit-popup
    markdown-mode
    metaweblog
    muse
    nzenburn-theme
    openwith
    org
    org2blog
    pandoc-mode
    popup
    ps-ccrypt
    quickrun
    runner
    ;scratch-persist
    screenshot
    simple-httpd
    ssh
    tao-theme
    twittering-mode
    weather-metno
    wget
    with-editor
    xml-rpc
    xterm-color
    yasnippet
    zenburn-theme
    zone-matrix
    )
    "Listado de paquetes que han de estar instalados o en caso negativo los instala.")
;
;;; Mostrar un mensaje de bienvenida en el minibuffer
;(defun display-startup-echo-area-message ()
;    (message "Activado emacs... ¡el editor de los dioses!"))
;
;;; Dividir el buffer en dos ventanas que son una continuación de la otra:
(follow-mode t)
;
;;; Diferenciar lo que es texto de lo que son órdenes para el formateo del texto:
;;; activado por defecto
;(global-font-lock-mode 1)
;
;;; Iluminar los parentesis y las llaves por parejas:
(show-paren-mode 1)
;
;;; Restablecer la posición del cursor al reabrir un archivo
;;; y activarlo para todos los buffers
(setq save-place-file "~/.emacs.d/saved-places")
(setq-default save-place t)
(custom-set-variables
'(save-place t nil (saveplace)))
;
;;; Usar decoración de texto siguiente:
;;;(bash, la máxima  [t], latex, la mínima [1], un entremedio. Sería valor 2
(setq font-lock-maximum-decoration
      '((shell-mode . t) (latex-mode . 2)))
;
;;; Que muestre las salidas de shell en colores:
;;; activado por defecto.
;(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;; especificar directorio y subdirectorios para las extensiones:
(let ((default-directory "~/.emacs.d/"))
    (normal-top-level-add-subdirs-to-load-path))
;
;;; Leer tambien el archivo de configuración:
(load "~/.gnu-emacs")
;
;;; Si tenemos un archivo sensible (contraseñas, códigos...) podemos
;;; ocultarlo del archivo de configuración. Las siguientes lineas
;;; lo leen si existe.
(if (file-exists-p "~/.emacs.secrets")
        (load-file "~/.emacs.secrets"))
;
;;; Modo inicial por defecto:
(setq default-major-mode 'text-mode)
;
;;; Dar permisos de execución al fichero si és un script
;;; y poderlo ejecutar con C-c e
(add-hook 'after-save-hook
  'executable-make-buffer-file-executable-if-script-p)
;
;;; Ver depuración de scripts de forma rápida (C-c r):
(require 'quickrun)
;
;;; No hacer copias de seguredad ni crear archivos #auto-save#
(setq make-backup-files nil)
(setq auto-save-default nil)
;;; Si quisiéramos copias de seguridad cada 2 minutos:
;(setq auto-save-timeout 120)
;;; o copias de seguridad cada 20 modficaciones:
;(setq auto-save-interval 20)
;;; O siempre:
;; (setq make-backup-files t)
;; (setq backup-by-copying t)
;; (setq version-control t) ;; numerando los backups
;; (setq delete-old-versions t) ;; Suprimiendo versiones viejas de backup
;
;;; guardar la sessión al cerrar emacs y restaurarla
;;; al arrancarlo de nuevo. Poner a cero [0] para desactivar:
(desktop-save-mode 1)
;
;;; No mostrar la barra del menú:
(menu-bar-mode -1)
;
;;; Esconder las contraseñas cuando se teclee:
;;; activado por defecto.
;(add-hook 'comint-output-filter-functions 'comint-watch-for-password-prompt)
;
;;; Abrir archivos comprimidos con gzip y bzip2:
(auto-compression-mode t)
;
;;; Reemplazar "yes" y "no" para "y" y "n" en el prompt
(fset 'yes-or-no-p 'y-or-n-p)
;
;;; Pedir confirmación para salir de emacs:
;(setq confirm-kill-emacs 'yes-or-no-p)
;
;;; Realzar la línea del foco. Atajo para activar/desactivar: C-c i
;;; y hacerlo con fondo azul:
(global-hl-line-mode 0)
(set-face-background 'hl-line "blue")
;
;;; Consultar indicador de bateria M-x display-battery-mode
;;; Activar indicador de bateria:
;(display-battery-mode 1)
;
;;; Mostrar tamaño del archivo en la linea de estado:
(size-indication-mode)
;
;;; reloj con formato 24 horas
;;; Mostrar fecha y hora
(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)
;
;;; Posar en català el calendari
(setq calendar-week-start-day 1
calendar-day-name-array ["Dg" "Dl" "Dt" "Dc" "Dj" "Dv" "Ds"]
calendar-month-name-array ["Gener" "Febrer" "Març" "Abril" "Maig" "Juny" "Juliol" "Agost" "Setembre" "Octubre" "Novembre" "Decembre"])
;;; Poner en castellano el calendario:
;calendar-day-name-array ["Lu" "Ma" "Mi" "Ju" "Vi" "Sa" "Do"]
;calendar-month-name-array ["Enero" "Febrero" "Marzo" "Abril" "Mayo" "Junio" "Julio" "Agosto" "Setiembre" "Octubre" "Noviembre" "Diciembre"])
;
;;; Añadir un espacio entre el número de linia y el texto de la línia:
(setq linum-format "%d ")
;
;;; Orden en el que se muestran los buffers según su importancia:
;(setq ido-file-extensions-order '(".txt" ".tex" ".emacs"))
;
;;; Ignorar mayúsculas en modo ido:
(setq ido-case-fold t)
;
;;; Insensible a mayúsculas y minúsculas en las busquedas:
(setq case-fold-search nil)
;
;;; Habilitar coincidencia aproximada:
(setq ido-enable-flex-matching t)
;
;;; Usar espacio en lugar de tabulaciones:
(setq-default indent-tabs-mode nil)
;
;;; Que las tabulaciones sean de 4 espacios:
(setq tab-width 4)
;
;;; Guardar contraseñas en la caché.
(setq-default password-cache-expiry nil)
;
;;; Eliminar espacios en blanco al final de la línia automáticament al guardar el archivo
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'write-file-hooks 'delete-trailing-whitespace nil t)
;
;;; Que los archivos de configuración se abran en lisp-mode
(add-to-list 'auto-mode-alist '("\\.emacs$" . lisp-mode)
			      '("\\.gnu-emacs$" . lisp-mode))
;
;;; Mover a la papelera al borrar archivos y directorios:
(setq delete-by-moving-to-trash t
      trash-directory "~/.local/share/Trash/files")
;
;;; Codificación utf-8
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
;
;;; No truncar el archivo de mensajes aunque sea grande:
;;; Por defecto 1000 lineas
(setq message-log-max t)
;
;;; Cuando sea necesario, expandir verticalmente la ventana del minibuffer
;;; para contener el texto que se coloca:
(setq resize-mini-windows t)
;
;;; alias para para eval-buffer:
;(defalias 'eb 'eval-buffer)
;
;;; Formatear las línias de un texto a 80 espacios
;;;  (M-x auto-fill-mode) Para hacerlo permanente:
;(setq auto-fill-mode 1)
;(setq fill-column 80)
;
;;; Indicar la columna al lado del número de linea en en la línea de modo:
(column-number-mode t)
;
;;; Preservar enlaces duros del archivo que se está editando.
;;; especialmente importante si se edita archivos de sistema:
(setq backup-by-copying-when-linked t)
;
;;; Preservar el propietario y el grupo del archivo que se está editando.
;;; especialmente importante si se edita archivos como root:
(setq backup-by-copying-when-mismatch t)
;
;;; Introducir el depurador cada vez que se encuentre un error:
;(setq debug-on-error t)
;
;;; Colocar marcas visibles en un buffer. Ejemplo:
;;; M-x bm-bookmark-line RET 235 (Marcarà la linea del cursor con el número
;;; 235. Para ver las marcas M-x: bm-show-all. Suprimir:
;;; M-x bm-remove-all-all-buffers o M-x bm-remove-all-current-buffer
;(require 'bm)
;
;
;;; Esconder comentarios de un script. Para esconder; M-x hide/show-comments
;;; Para mostrar: M-x hide/show-comments-toggle
(require 'hide-comnt)
;
;;; Guardar un completo historial de todo lo que ocurre en la sesión:
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))
;
;
;;; Para conocer dia y hora actual en distintos puntos del globo.
;;; M-x display-time-world
;(setq display-time-world-list '(("Europe/Oslo" "Oslo")
;                                ("America/Buenos_Aires" "Buenos Aires")
;    		                 ("America/New_York" "New York")
;                                ("America/Bogota" "Bogotá")
;                                ("Asia/Tokyo" "Tokyo")
;                                ("Australia/Melbourne" "Melbourne")))
;
;
;;; Para conocer el tiempo en determinada ciudad, en este caso
;;; Figueres (España). M-x weather-metno-forecast
;;; Descargar de: https://github.com/ruediger/weather-metno-el
;(add-to-list 'load-path "~/.emacs.d/weather-metno")
(require 'weather-metno)
(setq weather-metno-location-name "Figueres, Spain"
      weather-metno-location-latitude 42.27
      weather-metno-location-longitude 2.96)
;
;;; dired
; que se muestren en primer lugar los directorios:
(setq dired-listing-switches "-aBhl --group-directories-first")
;;; En dired, asociar extensiones a determinadas aplicaciones.
;;; M-x runner-add-extension (C-c C-c para guardar la asociación))
(require 'runner)
;
;;; Abrir en el navegador github o bitbucket con M-x browse-at-remote
;;; La primera vez, entrar en el directorio y lanzar:
;;; git config --add browseAtRemote.type "github"
(require 'browse-at-remote)
;
;;; Convertir textos a html.
(require 'htmlize)
;
;;; colocar shebang automaticamente al crear un script con extensión sh, perl y python
;;; para otros lenguajes añadirlos en M-x customize-group RET insert-shebang
(require 'insert-shebang)
(add-hook 'find-file-hook 'insert-shebang)
(custom-set-variables
 ;; modificar la shell por defecto y excluir determinadas extensiones
 '(insert-shebang-custom-headers (quote (("sh" . "#!/bin/bash"))))
 '(insert-shebang-ignore-extensions (quote ("txt" "org" "el" "tex" "html"))))
;
;;; Para que cuando se usen teclas "incorrectas" (flechas, RePág...) emacs le diga
;;; en el minibuffer las que tiene que usar (C-f, C-v...)
;(guru-global-mode +1)
;;; Si sólo quiere una advertencia:
;(setq guru-warn-only t)
;
;;; Si queremos guardar notas o trabajos en el buffer scratch y que estas
;;; persistan aunque cerremos emacs:
;(require 'scratch-persist)
;
;;; Si queremos abrir un archivo o buffer inexistente que pida confirmación:
(setq confirm-nonexistent-file-or-buffer t)
;
;;; No mostrar el puntero del mouse:
(setq make-pointer-invisible t)
;
;;;;;;;;;;;;;;;;;;;;;;;;; Keys;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Comentar trozos de codigo:
(global-set-key (kbd "C-c c") 'comment-region)
;;; Descomentar trozos de codigo:
(global-set-key (kbd "C-c u") 'uncomment-region)
;;; Ir a la línea...
(global-set-key (kbd "C-c g") 'goto-line)
;;; Abrir terminales:
(global-set-key (kbd "C-c t") 'multi-term-next)
(global-set-key (kbd "C-c T") 'multi-term) ;; Abrir nueva terminal
;;; Abrir firefox:
(global-set-key (kbd "C-c f") 'browse-url-firefox)
;;; Abrir una URL de w3m en el navegador externo:
(global-set-key (kbd "C-c a") 'w3m-external-view-this-url)
;;; Poner el cursor sobre una URL de un texto y abrirla en el firefox
;;; Creada la función w3mext
(global-set-key (kbd "C-c b") 'w3mext-open-link-or-image-or-url)
;;; executar scripts:
(global-set-key (kbd "C-c e") 'executable-interpret)
;;; executar scripts con quickrun:
(global-set-key (kbd "C-c r") 'quickrun)
;;; Abrir menu de los buffers abiertos:
(global-set-key (kbd "C-c m") 'buffer-menu)
;;; imprimir a ps (C-u M-x ps-print-buffer-with-faces)
;;; pasar a pdf: ps2pdf arxiu.ps arxiu.pdf
;(global-set-key (kbd "C-c i") 'ps-print-buffer-with-faces)
;;; Atajos de teclado para latex (skeleton)
;;; Resaltar la linea del foco:
(global-set-key (kbd "C-c i") 'global-hl-line-mode)
;;; skeleton dialeg:
(global-set-key (kbd "C-c d") 'dialeg)
;;; skeleton quadre:
(global-set-key (kbd "C-c q") 'quadre)
;;; skeleton argument:
(global-set-key (kbd "C-c z") 'argument)
;;; skeleton plantilla:
(global-set-key (kbd "C-c y") 'plantilla)
;;; skeleton logo:
(global-set-key (kbd "C-c l") 'logo)
;;; Abre listado de archivos o directorios de forma rápida:
(global-set-key (kbd "C-c x") 'open)
;;; Crear backup del buffer actual:
(global-set-key (kbd "C-c v")'make-backup)
;;; Imprimir buffer a pdf con C-c p
(global-set-key (kbd "C-c p") 'pdf-save-buffer)
;;; Esconder/mostrar archivos ocultos:
(global-set-key (kbd "C-c w") 'dired-dotfiles-toggle)
;;; Lanzar magit status
(global-set-key (kbd "C-c C-g") 'magit-status)
;;; Entrar terminal ansi-ter al pulsar F5:
(global-set-key (kbd "<f5>") '(lambda ()(interactive)(ansi-term "/bin/bash")))
;;; No cortar la palabra al final de la línia, clicando F6:
(global-set-key (kbd "<f6>") 'global-visual-line-mode)
;;; Mostar/esconder números de línia con F7 (Linum-Mode)
(global-set-key (kbd "<f7>") 'global-linum-mode)
;;; Abrir con app externa con F8:
(global-set-key (kbd "<f8>") 'external-app)
;;; lanzar blog de notas con F9:
(global-set-key (kbd "<f9>") 'remember)
;;; Lanzar el buffer scratch con C-c s:
(global-set-key (kbd "C-c s")
  (lambda()(interactive)(switch-to-buffer "*scratch*")))
;;; Abrir el tractatus
(global-set-key (kbd "C-t") 'tractatus)
;;; llanzar el directorio .emacs.d con C-c 1:
(global-set-key (kbd "C-c 1")
  (lambda()(interactive)(find-file "~/.emacs.d")))
;;; Reabrir alguno de los últimos 25 buffer abiertos,
;;; incluso los cerrados:
(global-set-key (kbd "C-c 2") 'recentf-open-files)
;;; Abrir dir del cursor en una ventana:
(global-set-key (kbd "C-c C-o") 'abrir-nueva-ventana)
;;; Encriptar region:
(global-set-key (kbd "C-c C-e") 'epa-encrypt-region)
;;; Descencriptar region:
(global-set-key (kbd "C-c C-d") 'epa-decrypt-region)
;;; Atajo para poner M-x en el minibuffer:
;(global-set-key (kbd "C-x x") 'execute-extended-command)
;;; Abrir nueva ventana vertical con un nuevo buffer
(global-set-key "\C-x4" 'split-window-vertically-other-buffer)
;;; Abrir nueva ventana horizontal con un nuevo buffer
(global-set-key "\C-x5" 'split-window-horizontally-other-buffer)
;;; Revertir todos los buffers abiertos a sus respectivos archivos:
(global-set-key (kbd "C-c B") 'revert-all-buffers)
;
;
;
;;;;;;;;;;;; Ajustes en las extensiones ;;;;;;;;;;;;
;
;
;;; blog de notas.
;;; Lanzar con M-x remember (o F9). C-c C-c para poner fecha y hora
;;; Crea el archivo ~/notes con todas las notas entradas:
;;; cd ~/.emacs.d
;;; git clone git://repo.or.cz/remember-el.git remember
;(add-to-list 'load-path "~/.emacs.d/lisp/remember")
(require 'remember)
;
;;; Multi-term
;;; Abrir con M-x multi-term o con el atajo (C-c t o C-c T). Descargar de:
;;; http://www.emacswiki.org/emacs/download/multi-term.el
(autoload 'multi-term "multi-term" nil t)
(autoload 'multi-term-next "multi-term" nil t)
;;; que use bash
(setq multi-term-program "/bin/bash")
;
;;; Referente al paquete ido:
(require 'ido)
;(setq ido-everywhere t)
(ido-mode 'buffers)
;;; Ignorar determinados buffers para que no salgan al pulsar C-x b
(setq ido-ignore-buffers '("^ " "*Completions*" "*Shell Command Output*"
                           "*Messages*" "Async Shell Command" "*scratch*"
                           "*tramp*"))
;;; Prioridad al mostrar determinadas extensiones:
(setq ido-file-extensions-order '(".emacs" ".sh" ".txt" ".el" ".tex" ))
;;; Ver el listado vertical cuando se pulsa C-x b
;;; M-x package-install y entrar:   ido-vertical-mode el paquete está a MELPA
;(require 'ido-vertical-mode)
;(ido-mode 1)
;(ido-vertical-mode 1)
;
;;; Navegador w3m:
;; (setq w3m-home-page "http://google.es"
;; w3m-default-display-inline-images t
;; w3m-display-inline-image t
;; w3m-resize-images t
;; w3m-use-cookies t
;; w3m-cookie-accept-bad-cookies t)
;
;;; ssh
;;; Acceso ssh (C-x C-f /ssh:usuario@IP:/home/usuario):
(require 'tramp)
(setq tramp-default-method "ssh")
;;; activar variables para ver salida de problemas con tramp
(setq tramp-debug-buffer t)
(setq tramp-verbose 10)
;;; otra forma más simple de acceder por ssh:
;;; M-x ssh RET user@host -p XXXX RET
(require 'ssh)
;
;;; Ajustar el prompt de eshell
;;; Modificar el prompt para mostrar el directorio de trabajo
;;; Para mostrar el usuario: (concat (getenv "USER")
(setq eshell-prompt-function
(lambda nil
(concat (eshell/pwd)
(if (= (user-uid) 0) " # " " $ "))))
;;; Especificar ruta a la shell que vamos a usar:
(setq explicit-shell-file-name "/bin/bash")
(setq shell-file-name explicit-shell-file-name)
;;; mensaje de bienvenida al entrar a la eshell:
(setq eshell-banner-message "\n... entrando en emacs shell...\n\n")
;
;;; Colores:
;;; Poner esquemas de colores
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/color-theme/"))
(require 'color-theme)
(color-theme-initialize)
;;; Esquema de color escogido:
;(color-theme-charcoal-black)
;(color-theme-calm-forest)
;(color-theme-lethe)
;(color-theme-oswald)
;(color-theme-taming-mr-arneson)
;(color-theme-jsc-dark)
;;; Al iniciar emacs, abrir el selector de colores para escoger el tema:
; (load-library "color-theme")
;     (color-theme-select)
;;; Si nos gusta determinada combinación pero la queremos invertida:
;(invert-face 'default)
;
;;; Reabrir algún buffer cerrado anteriormente
;;; El atajo de teclado es C-c 2
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-saved-items 200)
(setq recentf-max-menu-items 35)
;
;; prevenir la limpieza periódica de archivos remotos:
(setq recentf-auto-cleanup 'never)
;
;;; Activar tomar descansos cada determinado periodo de tiempo:
;;; type-break-mode activa/desactiva la extensión
;(require 'type-break)
;;; Frecuencia para tomar descansos en segundos (1 hora) :
;(setq type-break-interval (* 60 60))
;;; Para cada frecuencia anterior parar 5 minutos:
;(setq type-break-good-rest-interval (* 60 5))
;
;;; Abrir con apps externas con "intro" (~/.emacs.d/lisp/openwith.el)
(require 'openwith)
(openwith-mode t)
(setq openwith-associations '(("\\.pdf\\'" "evince" (file))
	                      ("\\.odt\\'" "lowriter" (file))
			      ("\\.ods\\'" "lowriter" (file))
	                      ("\\.png\\'" "gthumb" (file))
			      ("\\.jpg\\'" "gthumb" (file))
			      ("\\.mp3\\'" "vlc" (file))
			      ("\\.mpeg\\'" "vlc" (file))
			      ("\\.avi\\'" "vlc" (file))
			      ("\\.flv\\'" "vlc" (file))
			      ))
;
;(require 'mm-util)
;(add-to-list 'mm-inhibit-file-name-handlers 'openwith-file-handler)
;
;;; emacs-wget (http://www.filewatcher.com/m/emacs-wget.tbz.29-1.html)
;;; Las descargas a ~/download
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/wget"))
(require 'wget)
(defvar wget-hide-status t
  "Por defecto ocultar ventana de descarga wget.")
;
;;; Modo latex
;;; Que cuando se cargue el mode mayor LaTeX se active automáticament RefTeX.
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
;;; Que AUCTeX delegue a RefTeX lo relativo a la generación de etiquetas.
(setq reftex-plug-into-AUCTeX t)
;;; Que AUCTeX detecte el uso de include o input
(setq-default TeX-master nil)
;;; Guardar automáticamente la compilación:
;(setq TeX-save-query nil)
;;; Analizar el documento al guardar:
(setq TeX-auto-save t)
;;; Analizar el documento al cargar:
(setq TeX-parse-self t)
;;; Para que los .tex se abran en latex-mode:
(add-to-list 'auto-mode-alist '("\\.tex$" . latex-mode))
;;; Corregir los comentarios mientras se escribe. No las etiquetas ni las variables:
;;; M-$ para ver opciones "i" para incorporar al diccionario.
(setq flyspell-mode nil)
;;; Modificar visor de pdfs y dvis (por defecto xdvi)
(setq TeX-view-program-selection
      '((output-dvi "DVI Viewer")
        (output-pdf "PDF Viewer")))
(setq TeX-view-program-list
      '(("DVI Viewer" "evince %o")
        ("PDF Viewer" "evince %o")))
;
;;; markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
;
;;; activar pandoc al abrir un markdown:
(load "pandoc-mode")
(add-hook 'markdown-mode-hook 'pandoc-mode)
;
;;; Para que los texinfo se abran en texinfo-mode:
(add-to-list 'auto-mode-alist '("\\.texi$" . texinfo-mode))
;
;;; Imprimir
(setq lpr-command "enscript")
;(setq lpr-command "xpp")
;;; list of strings to pass as extra options for the printer program
;(setq lpr-switches (list "--font=Courier10"
;                         "--no-header"
;                         "--encoding=pslatin1"))
;                   (format "--header=%s" (buffer-name))))
(setq printer-name "psc-1100-series")
;
;;; Escuchar música con emms:
;(add-to-list 'load-path "~/.emacs.d/lips/")
(require 'emms)
(emms-standard)
(emms-default-players)
(setq emms-source-file-default-directory "~/musica_dades/")
;
;;; Limpiar con antiword ficheros .doc (apt-get install antiword)
;;; http://www.emacswiki.org/emacs/download/no-word.el
(autoload 'no-word "no-word" "word to txt")
 (add-to-list 'auto-mode-alist '("\\.doc$" . no-word))
;
;;; Activar comandos visuales en eshell:
(defcustom eshell-visual-commands
"Comandos a los que activar visual-commands"
  '("htop"))
(add-to-list 'eshell-visual-commands "htop")
;
;;; Guardar historial de eshell al cerrar sesión,
;;; especificando longitud y sin repetir comandos:
(setq eshell-history-size 20000)
(setq eshell-save-history-on-exit t)
(setq eshell-hist-ignoredups t)
;
;; EasyPG (GPG para emacs)
(require 'epa-file)
(epa-file-enable)
;
;;; ccrypt (encriptar archivos)
(setq load-path (cons "~/.emacs.d/lisp/ps-ccrypt" load-path))
(require 'ps-ccrypt "ps-ccrypt.el")
;
;;; Bookmarks pulsando M-r en firefox colocará en el archivo mencionado
;;; la url(%l), fecha(%t) y colocará el cursor al final de la linea(%?)
;;; por si añado un comentario. C-c C-c para terminar. Precisa ajustes
;;; en el navegador.
(server-start)
(require 'org-protocol)
(setq org-capture-templates
      (quote (("f" "Firefox" entry (file "/home/pep/.emacs.d/org/bookmarks.org")
                    "* %l %t %?\n")
              )))
;
;;; Paquete que proporciona un conjunto de funciones y combinaciones de teclas
;;; para el lanzamiento de las búsquedas de Google desde dentro de emacs.
;;; Para ver todas las opciones C-c C-h
(require 'google-this)
(google-this-mode t)
;
;;; fases de la luna. C-x lunar-phases
(with-eval-after-load 'lunar
    (setq lunar-phase-names '("Nueva" "Creciente" "Llena" "menguante")))
;
;;; screen (M-x escreen-create-screen)
;;; C-x escreen-menu (menú screen) C-\ p (ir al siguiente screen)
;;; C-\ n (ir al anterior) C-\ k (matar un screen)
;(require 'escreen)
;(escreen-install)
;
;;; Que las regiones seleccionadas se vean con fondo blanco y letra negra:
(set-face-attribute 'region nil :background "#666" :foreground "#ffffff")
;
;;; Añadir automáticamente paréntesis, llave y comillas
;;; de cierre al insertar la de apertura.
;(setq skeleton-pair t)
;(global-set-key "[" 'skeleton-pair-insert-maybe)
;(global-set-key "(" 'skeleton-pair-insert-maybe)
;(global-set-key "{" 'skeleton-pair-insert-maybe)
;(global-set-key "'" 'skeleton-pair-insert-maybe)
;
;
;;; Plantilla logo ;;;;;;;;;;;;;;;;
(define-skeleton logo
  "Cabecera (C-c l)"
  "logo: "
  ";;                   ___ _ __ ___   __ _  ___ ___                  \n"
  ";;                  / _ \\ '_ ` _ \\ / _` |/ __/ __|                 \n"
  ";;                 |  __/ | | | | | (_| | (__\\__ \\                 \n"
  ";;                (_)___|_| |_| |_|\\__,_|\\___|___/                 \n"
  ";;                               .-.                               \n"
  ";; =--------------------------   /v\\  ----------------------------=\n"
  ";; = lapipaplena.org            // \\\\              templix@gmx.es =\n"
  ";; =-----------------          /(   )\\        --------------------=\n"
  ";; =                            ^^-^^                             =\n"
  ";; =         https://tractatuslapipaplena.herokuapp.com/          =\n"
  ";; =--------------------------------------------------------------=\n")
;
;;; Plantillas skeleton para latex de muestra:
;; (define-skeleton dialeg
;;   "Para los diálegos de los personages(C-c d)"
;;   "dialeg: "
;;   "\\begin{quote}\n"
;;   "  \\textsl{ }\n"
;;   "\n "
;;   "\\end{quote}\n")
;;;
;; (define-skeleton quadre
;;   "Quadros de opciones(C-c q)"
;;   "quadre: "
;;   "\\begin{table}[htb]\n"
;;   "\\centering\n"
;;   "\\begin{tabular}{||l | c || c | l ||}\n"
;;   "\\hline\n"
;;   "\n "
;;   "\\hline\n"
;;   "\\end{tabular}\n"
;;   "\\caption{   }\n"
;;   "\\end{table}\n")
;;;
;; (define-skeleton argument
;;   "El argumento general(C-c z)"
;;   "argument: "
;;   "\\vspace{15mm}\n"
;;   "\\hline\n"
;;   "\n "
;;   "\\hline\n"
;;   "\\begin{center}\n"
;;   "\\Ovalbox{\\large\\bf ...}\n"
;;   "\\end{center}\n")
;;;
(define-skeleton plantilla
	"Plantilla de encabezado latex (C-c u)"
	"Plantilla: "
"\\documentclass[a4paper,openright,oneside,12pt]{book}\n"
"\\usepackage{geometry}\n"
"\\usepackage{url}\n"
"\\usepackage[spanish]{babel}\n"
"\\usepackage{html,makeidx}"
"\\usepackage[T1]{fontenc}\n"
"\\usepackage{textcomp}\n"
"\\usepackage[utf8]{inputenc}\n"
"\\usepackage{fancybox}\n"
"\\usepackage{framed}\n"
"\\usepackage{wedn}\n"
"\\usepackage{utopia}\n"
"\\usepackage{pbsi}\n"
"\\usepackage{suetterl}\n"
"\\usepackage{verbatim}\n"
"\\usepackage{url}\n"
"\\usepackage{setspace}\n"
"\\usepackage[framemethod=tikz]{mdframed}\n"
"\\usepackage{incgraph}\n"
"\\usepackage{xcolor}\n"
"\\usepackage{colortbl}\n"
"\\usepackage{multirow}\n"
"\\usepackage{wrapfig}\n"
"\\usepackage{fancyvrb}\n"
"\\usepackage{lipsum}\n"
"\\usepackage{fullpage}\n"
"\\usepackage{listings}\n"
"\\usepackage{graphicx}\n"
"\\usepackage{parskip}\n"
"\\textheight=25cm\n"
"\\textwidth=18cm\n"
"\\oddsidemargin=-1cm\n"
"\\topmargin=-1cm\n"
"\n"
"\\begin{document}\n"
"\n"
"\n"
"\n"
"\\end{document}\n")
;
;
;
;
;;;;;;;;;;; FUNCIONES ;;;;;;;;;;;;;;;;;;;;;;
;
;
(defun open-link ()
    "Poner el cursor sobre una URL de un texto un link o una imagen y abrirla con firefox.
 El atajo de teclado es C-c b."
    (interactive)
    (let (url)
      (if (string= major-mode "w3m-mode")
	          (setq url (or (w3m-anchor) (w3m-image)
				w3m-current-url)))
          (browse-url-firefox (if url url (car
					   (browse-url-interactive-arg
					    "URL: "))))
	  ))
;
;;; Abrir archivos o directorios de forma rápida (C-c x) M-x open.
;(require 'ido)
(defvar filelist nil "Lista de archivos o directorios que permite
abrirlos de forma rápida.")
(setq filelist
      '(
        ("telegram" . "~/.telegram-cli/downloads" )
        ("backups" . "/media/DADES/dades/arxius_importants/" )
        ("tractatus" . "~/tractatus/tractatus.txt" )
        ;; Más entradas ...
        ) )
;
(defun open (openCode)
  "Función para abrir el archivo o directorio predefinido"
  (interactive
   (list (ido-completing-read "Open:" (mapcar (lambda (x) (car x))
					      filelist)))
   )
  (find-file (cdr (assoc openCode xah-filelist))))
;
;;; Otra forma de acceder a determinados archivos.
;;; Pulsando "C-x r j" y la letra que indica después del interrogante
;;; Ejemplo: "C-x r j b" para ir a .bashrc
(mapcar
 (lambda (r)
   (set-register (car r) (cons 'file (cdr r))))
 '((?l . "~/.config/openbox/lxde-rc.xml")
   (?b . "~/.bashrc")))
;
;
;;; Crear backup del buffer abierto. El nombre será del tipo:
;;; nombre-fecha.old en el mismo directorio. Si existe, se sobreescribe
;;; El atajo de teclado es: C-c v
(defun crear-backup ()
  (interactive)
  (if (buffer-file-name)
      (let* ((currentName (buffer-file-name))
             (backupName (concat currentName "-" (format-time-string
                                                  "%Y%m%d_%M%S")
				  ".old")))
        (copy-file currentName backupName t)
        (message (concat "El backup se guarda con el nombre: " (file-name-nondirectory
					      backupName))))
    (user-error "El buffer no es un archivo.")
    ))
;
;;; Copiar la ruta del archivo del presente buffer (Pegarla con C-x y):
(defun copy-file-path (&optional φdir-path-only-p)
  "Copiar la ruta del archivo del presente buffer (Pegarla con C-x y)"
  (interactive "P")
  (let ((fPath
         (if (equal major-mode 'dired-mode)
             default-directory
           (buffer-file-name))))
    (kill-new
     (if (equal φdir-path-only-p nil)
         fPath
       (file-name-directory fPath))))
  (message "Ruta del archivo copiada."))
;
;;; Otra función para lo mismo y más simple:
(defun copiar-ruta ()
  "Copiar la ruta del archivo del presente buffer (Pegarla con C-x y):"
  (interactive)
  (kill-new buffer-file-name t)
  (message "Ruta del archivo copiada."))
;
;;; Función para pasar buffer a ps:
(require 'ps-print nil t)
(setq
 ps-paper-type 'a4
 ps-print-header nil;Sin encabezado
 )
(defun ps-print-in-file (filename)
  "Imprimir el presente buffer a un archivo en postscript"
       (interactive "FPS file: ")
;         (ps-print-buffer-with-faces filename));en colores
       (ps-print-buffer filename));sin colores
;
;
;;; Función para pasar un buffer a pdf:
(when (executable-find "ps2pdf")
  (defun pdf-print (&optional filename)
        "Imprime el buffer a pdf. Si se ejecuta con: C-u M-x pdf-print pedirá nombre
para guardar el pdf sinó, por defecto usa el mismo con extensión pdf."
        (interactive (list (if current-prefix-arg
                               (ps-print-preprint 4)
                             (concat (file-name-sans-extension (buffer-file-name))
                                     ".ps"))))
        (ps-print-with-faces (point-min) (point-max) filename)
        (shell-command (concat "ps2pdf " filename))
        (delete-file filename)
            (message "Guardado en %s" (concat (file-name-sans-extension filename) ".pdf"))))
;
;
;;; Función para insertar la fecha:
(defun insert-date ()
  "Inserta dia semana, fecha dd-mm-yyyy y hora, minutos y segundos"
  (interactive)
  (when (use-region-p)
    (delete-region (region-beginning) (region-end) )
    )
  (insert (format-time-string "%a-%x--%A")))
;
;;; Función para copiar una linea al portapapeles:
(defun copy-line (arg)
  "Copiar linea al portapapeles"
  (interactive "p")
  (kill-ring-save (line-beginning-position)
		  (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))
;
;;; Apps externas:
;;; En dired, Para arrancar apps externas clicando F8 o M-x external-app:
(defun external-app ()
 "Abrir archivo con apps externas."
  (interactive)
  (let* ((file (dired-get-filename nil t)))
    (call-process "xdg-open" nil 0 nil file)))
;;; Abrir nautilus con "M-x open-dir":
(defun open-dir ()
  "Show current dir"
  (interactive)
  (cond ((let ((process-connection-type nil)) (start-process "" nil "nautilus" ".")))))
;
;;; En dired, función para mostrar/esconder archivos ocultos clicando C-c w
(defun dired-dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p)
        (progn
          (set (make-local-variable 'dired-dotfiles-show-p) nil)
          (message "h")
          (dired-mark-files-regexp "^\\\.")
          (dired-do-kill-lines))
      (progn (revert-buffer)
                    (set (make-local-variable 'dired-dotfiles-show-p) t)))))
;
;;; Abrir directorios en una nueva ventana
(defun ventana-nueva-p (path)
    "devuelve t si el patch es un directorio
y  nil si patch es un archivo"
    (car (file-attributes path)))
(defun abrir-nueva-ventana ()
  "Abrir el directorio del cursor en nueva ventana"
  (interactive)
  (require 'ffap)
  (let ((file (or (ffap-url-at-point)
                  (ffap-file-at-point))))
    (unless (stringp file)
      (error"No file or URL found"))
    (when (file-exists-p (expand-file-name file))
      (setq file (expand-file-name file)))
    (message "Open: %s" file)
    (if (ventana-nueva-p file)
        (dired-other-window file)
      (find-file-other-window file))
    ))
;;; Atajo para esta función:
(global-set-key (kbd "\C-c C-o") 'abrir-nueva-ventana)
;
;;; Copi/paste emacs --> X e X --> emacs
;;; http://hugoheden.wordpress.com/2009/03/08/copypaste-with-emacs-in-terminal/
(setq x-select-enable-clipboard t)
(unless window-system
 (when (getenv "DISPLAY")
 (defun xsel-cut-function (text &optional push)
    (with-temp-buffer
    (insert text)
    (call-process-region (point-min) (point-max) "xsel" nil 0 nil "--clipboard" "--input")))
 (defun xsel-paste-function()
    (let ((xsel-output (shell-command-to-string "xsel --clipboard --output")))
      (unless (string= (car kill-ring) xsel-output)
        xsel-output )))
    (setq interprogram-cut-function 'xsel-cut-function)
    (setq interprogram-paste-function 'xsel-paste-function)))
;
;;; Algunas funciones de wget:
(defun wget-hide ()
  "Esconder la información de la descarga."
  (interactive)
  (if (bufferp (get-buffer wget-process-buffer))
      (delete-window (get-buffer-window (get-buffer wget-process-buffer))))
  (setq wget-hide-status t))
(defun wget-show ()
  "Mostrar información de la descarga."
  (interactive)
  (call-interactively 'wget-state-of-progress)
  (setq wget-hide-status nil))
(provide 'wget-extension)
;
;;; Mover lineas arriba o abajo. Por defecto sin especificar cantidad, una.
;;;  C-u 4 M-x move-line-down (4 lineas abajo)
(defun move-line (n)
  "Mover la linea arriba o abajo N lineas."
  (interactive "p")
  (let ((col (current-column))
        start
        end)
    (beginning-of-line)
    (setq start (point))
    (end-of-line)
    (forward-char)
    (setq end (point))
    (let ((line-text (delete-and-extract-region start end)))
      (forward-line n)
      (insert line-text)
      ;; Restaurar linea y columna original
      (forward-line -1)
      (forward-char col))))
;
(defun move-line-up (n)
  "Mover N lineas arriba."
  (interactive "p")
  (move-line (if (null n) -1 (- n))))
;
(defun move-line-down (n)
  "Mover N lineas abajo."
  (interactive "p")
    (move-line (if (null n) 1 n)))
;
;;; Buscar en la página de google del navegador por defecto
;;;  la palabra sobra la que esté el cursor:
(defun google-define ()
  "Buscar en google la palabra bajo el cursor."
  (interactive)
  (browse-url
(concat "http://www.google.com.pe/search?hl=en&q=define%3A"
                       (thing-at-point 'word))))
;
;;; Función para abrir directamente el tractatus con C-t:
;(defun tractatus ()
;  "Obrir el tractatus `~/tractatus/tractatus.txt'."
;    (interactive)
;      (find-file "~/tractatus/tractatus.txt"))
;
;;; Abrir mi .bashrc:
(defun bashrc ()
  "Abrir `~/.bashrc'."
  (interactive)
    (find-file "~/.bashrc"))
;
;;; Función para abrir archivos con privilegios de administrador
(defun sudo-open-file (file)
  "Abrir archivo com privilegios de root"
  (interactive "FFind file: ")
  (set-buffer
   (find-file
    (concat "/sudo::"
            (expand-file-name file)))))
;
(defun abrir-buffer-con-firefox()
  (interactive)
  (let ((filename (buffer-file-name)))
        (browse-url-firefox (concat "file://" filename))))
;
(define-skeleton proyecto
  "Una muestra de cabecera de un proyecto"
    ""(setq a1 (skeleton-read "Comment symbol? "))
    " ==============================="\n
  a1" Proyecto: " (skeleton-read  "Proyecto: ") \n
  a1" Año de entrega: " (skeleton-read  "Año: ") \n
  a1" Datos extras: " (skeleton-read  "Datos: ") \n
  a1" Fecha: "  (current-time-string) \n
  a1" Autor: Templix" \n
  a1" ===============================" \n
  \n \n )
;
;;; M-x saludo
(define-skeleton saludo
  "Saluda al interfecto"
  "Pon tu nombre: "
  "Hola, " str "!")
;
;;; M-x navegador-archivos
(defun navegador-archivos ()
  "Mostrar la gui del navegador de archivos del sistema."
  (interactive)
  (cond
   ((let ((process-connection-type nil)) (start-process "" nil "xdg-open" "."))
        ) ))
;
(defun put-ipsum ()
 "Inserta 10 párrafos de lorem ipsum en el lugar del cursor"
  (interactive)
      (insert (shell-command-to-string "lorem -p 10")))
;
(defun mostrar-ruta-archivo ()
  "Muestra en el minibuffer la ruta completa del presente buffer."
  (interactive)
  (let ((file-name (buffer-file-name)))
    (if file-name
	(progn
	  (message file-name)
	  (kill-new file-name))
            (error "El buffer no corresponde a un archivo"))))
;
(defun create-scratch-buffer nil
  "crear un nuevo buffer scratch"
  (interactive)
  (let ((n 0)
	bufname)
    (while (progn
	     (setq bufname (concat "*scratch"
				   (if (= n 0) "" (int-to-string n))
				   "*"))
	     (setq n (1+ n))
	     (get-buffer bufname)))
    (switch-to-buffer (get-buffer-create bufname))
        (emacs-lisp-mode)))
;
(defun su ()
  "Reabrir el presente buffer como root."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
     (concat "/su::" buffer-file-name))))

(defun sudo ()
  "Reabrir el presente buffer con sudo."
  (interactive)
  (when buffer-file-name
    (find-alternate-file
          (concat "/sudo:root@localhost:" buffer-file-name))))
;
(defun cc ()
"función para para eval-buffer (M-x cc)"
  (interactive)
  (call-interactively 'eval-buffer)
  (message "El buffer ha sido correctamente evaluado"))
;
(defun borrar-linies (&optional arg)
"Borrar lineas con independencia del lugar del cursor. Atajo C-c C-n"
  (interactive "p")
  (let ((here (point)))
	(beginning-of-line)
	(kill-line arg)
	(goto-char here)))
;
(defun electric-indent-ignore-text (char)
  "Ignorar indentacion en archivos de texto (text-mode)"
  (if (equal major-mode 'text-mode)
	  'no-indent
	nil))
(add-hook 'electric-indent-functions 'electric-indent-ignore-text)
;
;;; Capturas de pantalla:
(require 'screenshot)
;;; Que las capturas se guarden en /home/USER/Imagenes
(setq screenshot-schemes
   '(
	;; Directorio local de las imágenes
	("local"
	              :dir "~/Imagenes/")))
(setq screenshot-default-scheme "local")
;
(defun split-window-vertically-other-buffer ()
  "Abrir nueva ventana vertical con un buffer distinto (C-x 4)"
  (interactive)
  (split-window-vertically)
  (set-window-buffer (next-window) (other-buffer)))
;
(defun split-window-horizontally-other-buffer ()
  "Abrir nueva ventana horizontal con un buffer distinto (C-x 5)"
  (interactive)
  (split-window-horizontally)
  (set-window-buffer (next-window) (other-buffer)))
;
(defun youtube-dl ()
  "Copiar la url en el navegador y bajar videos de youtube al directorio ~/Baixades"
  (interactive)
  (let* ((str (current-kill 0))
	 (default-directory "~/Baixades")
	 (proc (get-buffer-process (ansi-term "/bin/bash"))))
    (term-send-string
     proc
     (concat "cd ~/Baixades && youtube-dl " str "\n"))))
;
;;; Un simple monitor de sistema que aparece en el minibuffer:
;(require 'symon)
;
;;; Salvapantallas de emacs. Activado a losd 60 segundos de inactividad.
;;; en debian precisa tener instalado el paquete xtrlock
(require 'zone)
(zone-when-idle 60)
;;; Activar un salvapantallas concreto. Por defecto aleatorio.
;(setq zone-programs [zone-pgm-drip-fretfully])
;
;;; Twitter
;;; activar iconos (sin efecto en -nw o -nox):
;(setq twittering-icon-mode t)
;;; Proteger la aplicación con un pass maestro:
;(setq twittering-use-master-password t)
(add-hook 'twittering-mode-hook (lambda () (visual-line-mode 1)))
;
;;; Feeds. Actualizar con M-x elfeed-update o con G
(setq elfeed-feeds
      '("http://www.genbeta.com/atom.xml"
	"http://www.linux-party.com/backend.php"
	"http://www.theinquirer.es/feed/atom"
	"http://feeds.feedburner.com/Command-line-fu"
	; más feeds
	"http://systemadmin.es/feed"))
;;; modificando algunos colores:
(custom-set-faces
 '(elfeed-search-date-face ((t (:background "black" :foreground "white"))))
 '(elfeed-search-date-format (quote ("%d-%m-%Y" 10 :left)))
 '(elfeed-search-feed-face ((t (:background "black" :foreground "white"))))
 '(elfeed-search-title-face ((t (:background "black" :foreground "white")))))
;;; aumentar el espació para los titulares. Por defecto 70
(custom-set-variables
  '(elfeed-search-title-max-width 120))
;;; Aguardar respuesta del host 30 segundos:
(setf url-queue-timeout 30)
;;; Actualizar cada media hora y mostrar un mensaje:
;(run-with-timer 0 3600 'elfeed-update)
;(defun elfeed-update ()
;    (message "Actualizadas noticias..."))
;
(defun delete-buffer-and-file ()
  "Eliminar el presente archivo y el buffer correspondiente."
  (Interactive)
  (Let ((filename (buffer-file-name))
	(buffer (current-buffer))
	(name (buffer-name)))
    (if (not (and filename (file-exists-p filename)))
	(error "El buffer '%s' no está siendo visitado..." name)
      (when (yes-or-no-p "¿Está seguro de querer eliminar el archivo? ")
	(delete-file filename)
	(kill-buffer buffer)
	(message "Archivo '%s' eliminado... " filename)))))
;
;;; a modo de ejemplo, insertar una salida de un comando con una función:
(defun insert-nmap ()
  "Insertar en el cursor el escaneo de la red"
  (interactive)
  (shell-command-on-region (point) (point) "nmap 192.168.1.0/24" t)
  (delete-backward-char 1))
;
;;; Gestión de los repositorios de github (C-c C-g activa magit-status)
;;; c c (escribir commit) C-c C-c (commit) P P (push) F F (pull) l l (log)
(require 'magit)
;;; especificar directorios git que se muestran en el minibuffer a escoger
;;; al pulsar C-c C-g (con C-u C-c C-g tambien deja escoger repositorio)
(custom-set-variables
 '(magit-repository-directories (quote ("~/repositorio1" "~/repositorio2" "~/repositorio3"))))
;
;;; Si se pretende abrir un archivo que no existe nos pedirá confirmación para crearlo:
;(setq confirm-nonexistent-file-or-buffer t)
;
;;; tipos de sistema
(defun insert-system-type()
(interactive)
(insert (format "%s" system-type)))
;
;;; nombre del sistema
(defun insert-system-name()
(interactive)
(insert (format "%s" system-name)))
;
;;; Colocar los comentarios en la columna 0
(defun comment-indent-default ()
    (setq comment-column 0))
;
;;; sudo:
;;; Forma de uso [C-x C-f /sudo::/etc/hosts]
;;; C-x C-f /sudo:root@localhost:/etc/hosts o C-x sudo-find-file
(defun sudo-find-file (file-name)
  "Like find file, but opens the file as root."
  (interactive "FSudo Find File: ")
  (let ((tramp-file-name (concat "/sudo::" (expand-file-name file-name))))
    (find-file tramp-file-name)))
;
(defun ddg-search (text)
  "Buscar en firefox con DuckDuckGoa partir de emacs un texto."
  (interactive "sUrl: ")
  (browse-url-firefox
   (concat "https://duckduckgo.com/?q="
		              (replace-regexp-in-string " " "+" text))))
;
(defun ddg-wikipedia (text)
  "Buscar en firefox con DuckDuckGo en la wikipedia"
  (interactive "sCercar a Wikipedia: ")
  (browse-url-firefox
   (concat "https://duckduckgo.com/?q=!wikipedia-es+"
		   (replace-regexp-in-string " " "+" text))))
;
(defun revert-all-buffers ()
  "Revertir todos los buffers abiertos a sus respectivos archivos"
  (interactive)
  (let* ((list (buffer-list))
		 (buffer (car list)))
	(while buffer
	  (when (buffer-file-name buffer)
		(progn
		  (set-buffer buffer)
		  (revert-buffer t t t)))
	  (setq list (cdr list))
	  (setq buffer (car list))))
  (message "Todos los archivos actualizados"))
;
;
;;;;;;;;;;;;;;;; end file .emacs ;;;;;;;;;;;;;;;;;;;;;;;
;
