----+-*A-1-B--+----2----+----3----+----4----+----5----+----6----+----7----+----
       IDENTIFICATION DIVISION.
       PROGRAM-ID. COPYNAME.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
          SELECT INFILE   ASSIGN TO "INPUT.DAT"   SEQUENTIAL.
          SELECT OUTFILE  ASSIGN TO "OUTPUT.DAT"  SEQUENTIAL.


       DATA DIVISION.
       FILE SECTION.
       FD INFILE.
       01 INPUT-RECORD                      PIC X(80).

       FD OUTFILE.
       01 OUTPUT-RECORD                     PIC X(80).

       WORKING-STORAGE SECTION.
       01 WS-INFILE-FS                      PIC X(01) VALUE 'N'.
         88 WS-EOF                                    VALUE 'Y'.

       01   INP-RECORD   VALUE SPACES.
         02  FIRST-NAME                     PIC X(15) VALUE SPACES.
         02  FILLER                         PIC X(01).
         02  MIDDLE-NAME                    PIC X(15) VALUE SPACES.
         02  FILLER                         PIC X(01).
         02  LAST-NAME                      PIC X(15) VALUE SPACES.

       01   OUT-RECORD   VALUE SPACES.
         02  FIRST-NAME                     PIC X(15) VALUE SPACES.
         02  FILLER                         PIC X(01).
         02  MIDDLE-NAME                    PIC X(15) VALUE SPACES.
         02  FILLER                         PIC X(01).
         02  LAST-NAME                      PIC X(15) VALUE SPACES.

       PROCEDURE DIVISION.

       A000-MAIN-PROCEDURE.
            DISPLAY "EXECUTING COPYNAME"
            PERFORM B000-OPEN-FILES.
            PERFORM D000-COPY-DISP-DATA.
            PERFORM Z999-END-PROGRAM.

       B000-OPEN-FILES.
            OPEN INPUT INFILE.
            OPEN OUTPUT OUTFILE.
            READ INFILE INTO INP-RECORD
              AT END
                  SET WS-EOF TO TRUE.
            IF WS-EOF THEN
                DISPLAY 'INPUT FILE EMPTY'
                PERFORM Z999-END-PROGRAM.

       D000-COPY-DISP-DATA.

            MOVE INP-RECORD TO OUT-RECORD.
            DISPLAY 'FIRST NAME:' FIRST-NAME OF OUT-RECORD.
            DISPLAY 'MIDDLE NAME:' MIDDLE-NAME OF OUT-RECORD.
            DISPLAY 'LAST NAME:' LAST-NAME OF OUT-RECORD.

            WRITE OUTPUT-RECORD FROM OUT-RECORD.
            MOVE SPACES TO OUT-RECORD.
            READ INFILE INTO INP-RECORD
              AT END
                  SET WS-EOF TO TRUE.

       Z999-END-PROGRAM.
            CLOSE INFILE.
            CLOSE OUTFILE.
            DISPLAY 'COPYNAME EXECUTION ENDS'
            STOP RUN.
       END PROGRAM COPYNAME.
