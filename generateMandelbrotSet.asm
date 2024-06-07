section .text
global generateMandelbrotSet

generateMandelbrotSet:
    ; Prologue: Save the current stack frame and save non-volatile registers
    push    rbp                 ; Save base pointer
    mov     rbp, rsp            ; Set base pointer to current stack pointer
    push    rbx                 ; Save rbx register (non-volatile)
    push    r12                 ; Save r12 register (non-volatile)

    ; r8 = row = height - 1 (initialize row loop counter)
    mov     r8, rdx             ; Move height to r8
    sub     r8, 1               ; Decrement by 1 to make it zero-based

rowLoop:
    ; r9 = col = width - 1 (initialize column loop counter)
    mov     r9, rsi             ; Move width to r9
    sub     r9, 1               ; Decrement by 1 to make it zero-based

colLoop:
    ; Calculate cReal (real part of the complex number)
    cvtsi2sd    xmm6, r9        ; Convert col to double and store in xmm6 (cReal)
    subsd       xmm6, xmm3      ; cReal = col - centerReal
    mulsd       xmm6, xmm0      ; cReal = (col - centerReal) * escapeRadius
    addsd       xmm6, xmm6      ; cReal = (col - centerReal) * escapeRadius * 2
    cvtsi2sd    xmm8, rsi       ; Convert width to double and store in xmm8
    mulsd       xmm8, xmm5      ; xmm8 = width * zoom
    divsd       xmm6, xmm8      ; cReal = (col - centerReal) * escapeRadius * 2 / (width * zoom)

    ; Calculate cImag (imaginary part of the complex number)
    cvtsi2sd    xmm7, r8        ; Convert row to double and store in xmm7 (cImag)
    subsd       xmm7, xmm4      ; cImag = row - centerImag
    mulsd       xmm7, xmm0      ; cImag = (row - centerImag) * escapeRadius
    addsd       xmm7, xmm7      ; cImag = (row - centerImag) * escapeRadius * 2
    cvtsi2sd    xmm8, rdx       ; Convert height to double and store in xmm8
    mulsd       xmm8, xmm5      ; xmm8 = height * zoom
    divsd       xmm7, xmm8      ; cImag = (row - centerImag) * escapeRadius * 2 / (height * zoom)

    ; Initialize zReal and zImag for Mandelbrot set
    xorpd       xmm9, xmm9      ; zReal = 0.0
    xorpd       xmm10, xmm10    ; zImag = 0.0

    ; Initialize iteration counter
    mov     rax, 0              ; iteration = 0

pixelWhileLoop:
    ; Check loop conditions
    ; Break if iteration == maxIteration == 128
    cmp     rax, 128            ; Compare iteration with 128
    je      pixelWhileLoopEnd   ; If equal, jump to pixelWhileLoopEnd

    ; Calculate zReal * zReal + zImag * zImag
    movsd   xmm8, xmm9          ; tmp1 = zReal
    mulsd   xmm8, xmm8          ; tmp1 = zReal * zReal
    movsd   xmm11, xmm10        ; xmm11 = zImag
    mulsd   xmm11, xmm11        ; xmm11 = zImag * zImag
    addsd   xmm8, xmm11         ; tmp1 = zReal * zReal + zImag * zImag

    ; Calculate escapeRadius * escapeRadius
    movsd   xmm11, xmm0         ; tmp2 = escapeRadius
    mulsd   xmm11, xmm11        ; tmp2 = escapeRadius * escapeRadius

    ; Break if (zReal * zReal + zImag * zImag) >= (escapeRadius * escapeRadius)
    comisd  xmm8, xmm11         ; Compare tmp1 and tmp2
    jae     pixelWhileLoopEnd   ; If greater or equal, jump to pixelWhileLoopEnd

    ; Loop body: Perform Mandelbrot iteration
    ; Calculate tmpReal = zReal * zReal - zImag * zImag
    movsd   xmm8, xmm9          ; xmm8 = zReal
    mulsd   xmm8, xmm8          ; xmm8 = zReal * zReal
    movsd   xmm11, xmm10        ; xmm11 = zImag
    mulsd   xmm11, xmm11        ; xmm11 = zImag * zImag
    subsd   xmm8, xmm11         ; xmm8 = tmpReal = zReal * zReal - zImag * zImag

    ; Calculate zImag = 2 * zReal * zImag + cImag
    addsd   xmm10, xmm10        ; xmm10 = 2 * zImag
    mulsd   xmm10, xmm9         ; xmm10 = 2 * zReal * zImag
    addsd   xmm10, xmm7         ; xmm10 = zImag = 2 * zReal * zImag + cImag

    ; Update zReal = tmpReal + cReal
    movsd   xmm9, xmm8          ; zReal = tmpReal
    addsd   xmm9, xmm6          ; zReal = tmpReal + cReal

    ; Increment iteration counter
    inc     rax                 ; iteration++

    ; Continue loop
    jmp     pixelWhileLoop      ; Jump back to pixelWhileLoop

pixelWhileLoopEnd:

    ; Calculate color based on iterations
    mov     rcx, 128            ; rcx = maxIteration
    sub     rcx, rax            ; rcx = maxIteration - iteration
    imul    rcx, 255            ; rcx = (maxIteration - iteration) * 255
    sar     rcx, 7              ; rcx = (maxIteration - iteration) * 255 / maxIteration (maxIteration == 128 == 2^7)

    ; Calculate pixel index
    mov     rbx, r8             ; rbx = row
    imul    rbx, rsi            ; rbx = row * width
    add     rbx, r9             ; rbx = row * width + col
    mov     r12, rbx            ; r12 = row * width + col
    shl     rbx, 1              ; rbx = 2 * (row * width + col)
    add     rbx, r12            ; rbx = 3 * (row * width + col)

    ; Store color in pixel array
    mov     byte [rdi + rbx], cl      ; Set red channel
    mov     byte [rdi + rbx + 1], cl  ; Set green channel
    mov     byte [rdi + rbx + 2], cl  ; Set blue channel

    ; Repeat while col >= 0
    dec     r9                  ; Decrement col
    jnz     colLoop             ; If not zero, jump to colLoop

colLoopEnd:
    ; Repeat while row >= 0
    dec     r8                  ; Decrement row
    jnz     rowLoop             ; If not zero, jump to rowLoop

rowLoopEnd:

    ; Epilogue: Restore saved registers and return
    pop     r12                 ; Restore r12 register
    pop     rbx                 ; Restore rbx register
    mov     rsp, rbp            ; Restore stack pointer
    pop     rbp                 ; Restore base pointer
    ret                         ; Return from function
