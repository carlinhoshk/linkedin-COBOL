       IDENTIFICATION DIVISION.
       PROGRAM-ID.     IMCCALCULADORA.
       AUTHOR.         Carlinhoshk.
      *Esse codigo não é igual ao do projeto.
      *Eles não usam kg e metros e o codigo ocupava muito em memoria.
      *Adaptei para o método Br
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
      *Especial-names eu aprendi NO livro que mostra como tratar ponto
      *E Virgula já que no Brasil é diferente do EUA em questão de ponto
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.

       DATA DIVISION.
           WORKING-STORAGE SECTION.
           01 weight PIC 9(3) VALUE 0.
           01 heights PIC 9(3) VALUE 0.
           01 bmi PIC 9(3) VALUE 0.
       
       PROCEDURE DIVISION.
       0100-START-HERE.
           DISPLAY "Entre com seu Peso aqui: ".
           ACCEPT weight.
           DISPLAY "Entre com sua Altura aqui: ".
           ACCEPT heights.
           
           COMPUTE bmi = weight / (heights ** 2).
           DISPLAY "Seu IMC é: " BMI, "%".

       STOP RUN.
       END PROGRAM IMCCALCULADORA.

