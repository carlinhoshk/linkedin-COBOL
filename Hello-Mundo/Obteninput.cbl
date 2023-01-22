       IDENTIFICATION DIVISION.
       PROGRAM-ID.     "OBTAININPUT".
       AUTHOR.         Carlinhoshk.
       
       ENVIRONMENT DIVISION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 NAME PIC A(20).

       PROCEDURE DIVISION.
           0100-START-HERE.
               DISPLAY "Porfavor entre seu nome: ".
               ACCEPT NAME.
               DISPLAY "É muito bom te conheçer, ", NAME.
       STOP RUN.
       END PROGRAM OBTAININPUT.
       