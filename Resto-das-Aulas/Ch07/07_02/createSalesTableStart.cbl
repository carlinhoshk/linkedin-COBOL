       IDENTIFICATION DIVISION.
       PROGRAM-ID. CREATETABLE.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
	   SELECT VIDEOGAMEFILE ASSIGN TO "VIDEOSALES.DAT"
		ORGANIZATION IS LINE SEQUENTIAL.
          
       DATA DIVISION.
       FILE SECTION.
	   FD VIDEOGAMEFILE.
	   01 GAMEDETAILS.
			88 ENDOFFILE VALUE HIGH-VALUES.
			02 SKU 	           PIC 9(4).
			02 GAME-TITLE      PIC X(20).
			02 QUARTLERY-SALES.
				03  QTRLY-SALES	PIC 9(5)
				    OCCURS 4 TIMES.
		 
       WORKING-STORAGE SECTION.   
	   01  WS-WORKING-STORAGE.
	       05  FILLER  PIC X(27) VALUE 
		       'WORKING STORAGE STARTS HERE'.			   
		   05  GAMETABLE-SUBSCRIPT  PIC 99 VALUE ZEROES.
           05  SUBSCRIPT            PIC 99.
           05  WS-TOTAL-GAMES       PIC 99 VALUE ZEROES.
         
		   05  WS-QTRLY-TOTALS.
               10  WS-QTRLY-TOTAL  PIC 9(6) 
                   OCCURS 4 TIMES.	
	   01  WS-REPORT-TITLE.
           05  FILLER     PIC X(20) VALUE SPACES.
           05  FILLER     PIC X(33) 
		        VALUE 'VIDEO GAME QUARTERLY SALES REPORT'.		   
       01  WS-HEADING-LINE.
	       05  FILLER     PIC X(30) VALUE 'GAME TITLE'.
		   05  FILLER     PIC X(6)  VALUE ' QTR 1'.
		   05  FILLER     PIC XXX.
	       05  FILLER     PIC X(6)  VALUE ' QTR 2'.
		   05  FILLER     PIC XXX.
	       05  FILLER     PIC X(6)  VALUE ' QTR 3'.
		   05  FILLER     PIC XXX.
		   05  FILLER     PIC X(6)  VALUE ' QTR 4'.		
	    
       01  WS-HEADING-LINE2.
	       05  FILLER     PIC X(30) VALUE 
		        '-------------------------'.
		   05  FILLER     PIC X(6) VALUE ' -----'.
		   05  FILLER     PIC X(3).
	       05  FILLER     PIC X(6) VALUE ' -----'.
		   05  FILLER     PIC X(3).
	       05  FILLER     PIC X(6) VALUE ' -----'.
		   05  FILLER     PIC X(3).
		   05  FILLER     PIC X(6) VALUE ' -----'.
	
	   01  WS-DETAIL-LINE.
	       05  WS-DET-SKU         PIC 9(5).
		   05  WS-DET-TITLE       PIC X(20).
		   05  FILLER             PIC XX VALUE SPACES.
		   05  WS-DET-AMT         OCCURS 4 TIMES.
		       07  FILLER         PIC XX.   
			   07  WS-DET-SALES   PIC $ZZ,999.
			   
       01  WS-TOTAL-LINE.
	       05  FILLER             PIC X(27).
		   05  WS-TOTALS          OCCURS 4 TIMES.
		       07  FILLER         PIC XX.   
			   07  WS-QTR-TOTALS  PIC $ZZ,999.	
 	   
       PROCEDURE DIVISION.      
	   0100-BEGIN.
		    
		   OPEN INPUT VIDEOGAMEFILE.
		   READ VIDEOGAMEFILE
			AT END SET ENDOFFILE TO TRUE
			END-READ.

		   DISPLAY WS-REPORT-TITLE.
		   DISPLAY WS-HEADING-LINE.	
		   DISPLAY WS-HEADING-LINE2.
           COMPUTE GAMETABLE-SUBSCRIPT = 1.		   
		   PERFORM 0200-PROCESS-RECORDS UNTIL ENDOFFILE.
		   PERFORM 0250-DISPLAY-DETAILS. 
           PERFORM 0220-CALCULATE-QTRLY-TOTALS.		   
           PERFORM 0300-STOP-RUN.
	   
	   0200-PROCESS-RECORDS.
            ADD 1 TO WS-TOTAL-GAMES. 
			MOVE SKU TO TABLE-SKU(GAMETABLE-SUBSCRIPT).
			MOVE GAME-TITLE TO 
			  TABLE-GAME-TITLE(GAMETABLE-SUBSCRIPT).
			MOVE QTRLY-SALES(1) TO 
			  TABLE-QTRLY-SALES(GAMETABLE-SUBSCRIPT,1).
			MOVE QTRLY-SALES(2) TO 
			  TABLE-QTRLY-SALES(GAMETABLE-SUBSCRIPT,2).
			MOVE QTRLY-SALES(3) TO  
			  TABLE-QTRLY-SALES(GAMETABLE-SUBSCRIPT,3).
			MOVE QTRLY-SALES(4) TO 
			  TABLE-QTRLY-SALES(GAMETABLE-SUBSCRIPT,4).
			COMPUTE GAMETABLE-SUBSCRIPT = 
			  GAMETABLE-SUBSCRIPT + 1.	
			READ VIDEOGAMEFILE 
			  AT END SET ENDOFFILE TO TRUE
			END-READ.

       0220-CALCULATE-QTRLY-TOTALS.    
			PERFORM VARYING SUBSCRIPT FROM 1 BY 1 
			   UNTIL SUBSCRIPT > WS-TOTAL-GAMES
               ADD TABLE-QTRLY-SALES(SUBSCRIPT,1) TO 
                 WS-QTRLY-TOTAL(1)
               ADD TABLE-QTRLY-SALES(SUBSCRIPT,2) TO 
                 WS-QTRLY-TOTAL(2)
               ADD TABLE-QTRLY-SALES(SUBSCRIPT,3) TO 
                 WS-QTRLY-TOTAL(3)
               ADD TABLE-QTRLY-SALES(SUBSCRIPT,4) TO 
                 WS-QTRLY-TOTAL(4)
            END-PERFORM.
            MOVE WS-QTRLY-TOTAL(1) TO WS-QTR-TOTALS(1).
            MOVE WS-QTRLY-TOTAL(2) TO WS-QTR-TOTALS(2).
            MOVE WS-QTRLY-TOTAL(3) TO WS-QTR-TOTALS(3).
            MOVE WS-QTRLY-TOTAL(4) TO WS-QTR-TOTALS(4).
            DISPLAY WS-TOTAL-LINE.

	   0250-DISPLAY-DETAILS.
	        
			PERFORM VARYING SUBSCRIPT FROM 1 BY 1 
			   UNTIL SUBSCRIPT > WS-TOTAL-GAMES
			   MOVE TABLE-SKU(SUBSCRIPT) TO WS-DET-SKU
			   MOVE TABLE-GAME-TITLE(SUBSCRIPT) TO 
			      WS-DET-TITLE
			   MOVE TABLE-QTRLY-SALES(SUBSCRIPT,1) 
			     TO WS-DET-SALES(1)
		       MOVE TABLE-QTRLY-SALES(SUBSCRIPT,2) 
			     TO WS-DET-SALES(2)
			   MOVE TABLE-QTRLY-SALES(SUBSCRIPT,3) 
			     TO WS-DET-SALES(3)
			   MOVE TABLE-QTRLY-SALES(SUBSCRIPT,4) 
			     TO WS-DET-SALES(4)
			   DISPLAY WS-DETAIL-LINE
			END-PERFORM.
	   0250-END.
	   
	   0300-STOP-RUN.	
		
           CLOSE VIDEOGAMEFILE.		
           STOP RUN.
           
          END PROGRAM CREATETABLE.
