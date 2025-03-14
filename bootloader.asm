[BITS 16]        ; Spécifier que nous sommes en mode 16 bits (mode réel)
[ORG 0x7C00]     ; Le BIOS charge le bootloader à cette adresse


section .text
    global _start

_start:
    mov si, message ; Charger l'adresse du message dans SI

print_loop:
    lodsb           ; Charger le caractère de DS:[SI] dans AL et avancer SI
    cmp al, 0       ; Vérifier si AL est 0 (fin de la chaîne)
    je halt         ; Si oui, sauter à la fin

    mov ah, 0x0e    ; Fonction 0x0E de l'interruption 0x10 (affichage en mode texte)
    int 0x10        ; Afficher le caractère dans AL
    jmp print_loop  ; Revenir au début de la boucle

halt:
    cli             ; Désactiver les interruptions
    hlt             ; Arrêter le CPU

message db "Welcome to the bootloader of Genesect-OS", 0 ; Chaîne de caractères à afficher
times 510-($-$$) db 0         ; Remplir le reste du secteur avec des zéros
dw 0xAA55                     ; Signature du secteur de boot