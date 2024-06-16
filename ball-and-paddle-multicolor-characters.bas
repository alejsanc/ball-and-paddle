10 FOR X=12800 TO 12800+63: READ Y: POKE X,Y: NEXT X: REM READ BALL SPRITE
20 FOR X=12864 TO 12864+63: READ Y: POKE X,Y: NEXT X: REM READ PADDLE SPRITE
30 POKE 2040,200: REM SET BALL SPRITE POINTER
40 POKE 2041,201: REM SET PADDLE SPRITE POINTER
50 B=1: REM BALL BIT
60 P=2: REM PADDEL BIT
70 PO=0: REM POINTS
80 PRINT CHR$(147)CHR$(144);
85 GOSUB 6000: REM PRINT BACKGROUND
90 FOR X=0 TO 39: PRINT CHR$(102);: NEXT X
100 PRINT "POINTS:"PO"     BALL AND PADDLE"
110 FOR X=0 TO 39: PRINT CHR$(101);: NEXT X                            
120 POKE 53276,B+P: REM SET SPRITES MULTICOLOR MODE
130 POKE 53277,P: REM SET PADDLE DOUBLE WIDTH
140 POKE 53281,3: REM SET BACKGROUND COLOR
150 POKE 53285,0: REM SET ALL SPRITES BORDER COLOR
160 X=RND(-TI): REM RND INITIALIZATION
170 POKE 53287,2: REM SET BALL SPRITE COLOR
180 POKE 53288,9: REM SET PADDLE SPRITE COLOR
190 POKE 54272,50: REM SET FREQUENCY VOICE 1 LOW BYTE
200 POKE 54273,70: REM SET FREQUENCY VOICE 1 HIGH BYTE
210 POKE 54277,0: REM SET ATTACK AND DECAY DURATION VOICE 1
220 POKE 54278,247: REM SET SUSTAIN LEVEL AND RELEASE DURATION
230 POKE 54296,15: REM SET FILTER MODE AND MAIN VOLUME CONTROL
240 CR=53278: REM SPRITES COLLISIONS REGISTER
250 ER=53264: REM SPRITES X COORDINATE EXTRA BITS REGISTER
260 POKE ER,0: REM CLEAR SPRITES X COORDINATE EXTRA BITS REGISTER
270 SR=53248: REM SPRITES COORDINATES REGISTERS
280 BR=SR: REM BALL COORDINATES REGISTERS
290 PR=SR+2: REM PADDLE COORDINATES REGISTERS
300 POKE BR,(RND(1)*200)+50: REM SET BALL X COORDINATE
310 POKE BR+1,(RND(1)*100)+50: REM SET BALL Y COORDINATE
320 POKE PR,(RND(1)*200)+50: REM SET PADDLE X COORDINATE
330 POKE PR+1,233: REM SET PADDLE Y COORDINATE
340 POKE 53269,B+P: REM ENABLE SPRITES
350 X=PEEK(CR): REM CLEAR SPRITES COLLISIONS REGISTER
360 BH=INT(RND(1)*2): REM SET BALL HORIZONTAL MOVEMENT
370 BV=INT(RND(1)*2): REM SET BALL VERTICAL MOVEMENT
380 PH=INT(RND(1)*2): REM SET PADDLE HORIZONTAL MOVEMENT
390 IF (BH=0) THEN BH=-1
400 IF (BV=0) THEN BV=-1
410 IF (PH=0) THEN PH=-1
420 FOR X=0 TO 1 STEP 0
430 BX=PEEK(BR): REM READ BALL X COORDINATE
440 BY=PEEK(BR+1): REM READ BALL Y COORDINATE
450 BE=PEEK(ER) AND B: REM READ BALL X COORDINATE EXTRA BIT
460 PX=PEEK(PR): REM READ PADDLE X COORDINATE
470 PE=PEEK(ER) AND P: REM READ PADDLE X COORDINATE EXTRA BIT
480 IF ((PEEK(CR) AND B+P) AND BV=1) THEN GOSUB 5000: REM DETECT COLLISION
490 IF (BE=0 AND BX=20) THEN BH=1 
500 IF (BE=B AND BX=68) THEN BH=-1
510 IF (BY=47) THEN BV=1
520 IF (BY=231) THEN GOTO 690
530 IF (BX=0 AND BH=-1) THEN GOSUB 1000: GOTO 560
540 IF (BX=255 AND BH=1) THEN GOSUB 2000: GOTO 560
550 POKE BR,BX+BH: REM UPDATE BALL X COORDINATE
560 POKE BR+1,BY+BV: REM UPDATE BALL Y COORDINATE
570 IF (PE=0 AND PX=24) THEN PH=1 
580 IF (PE=P AND PX=40) THEN PH=-1
590 IF (PX=0 AND PH=-1) THEN GOSUB 3000: GOTO 620
600 IF (PX=255 AND PH=1) THEN GOSUB 4000: GOTO 620
610 POKE PR,PX+PH: REM UPDATE PADDLE X COORDINATE
620 GET K$: REM READ KEY PRESS
630 IF (K$="J") THEN PH=-1
640 IF (K$="K") THEN PH=1
650 J1=PEEK(56321): REM READ JOYSTICK 1 REGISTER
660 IF (J1 AND 4)=0 THEN PH=-1
670 IF (J1 AND 8)=0 THEN PH=1
680 NEXT X
690 FOR X=1 TO 10: PRINT: NEXT X: REM PRINT 10 NEW LINES
700 PRINT SPC(15)"GAME OVER": REM PRINT 15 SPACES AND GAME OVER MESSAGE
710 END
1000 POKE ER,PEEK(ER) - B: POKE BR,255: RETURN: REM DISABLE BALL EXTRA BIT
2000 POKE ER,PEEK(ER) + B: POKE BR,0: RETURN: REM ENABLE BALL EXTRA BIT
3000 POKE ER,PEEK(ER) - P: POKE PR,255: RETURN: REM DISABLE PADDLE EXTRA BIT
4000 POKE ER,PEEK(ER) + P: POKE PR,0: RETURN: REM ENABLE PADDLE EXTRA BIT
5000 POKE 54276,32+1: REM START SOUND
5010 BV=-1
5020 BT=BX: PT=PX: REM COPY X COORDINATES
5030 IF (BE=B) THEN BT=256+BT: REM BALL TOTAL X COORDINATE
5040 IF (PE=P) THEN PT=256+PT: REM PADDEL TOTAL X COORDINATE
5050 SD=BT-PT: REM SPRITES DISTANCE
5060 IF (SD>35) THEN BH=1
5070 IF (SD<-11) THEN BH=-1
5080 PO=PO+1: PRINT CHR$(19)CHR$(17)"POINTS:"PO
5090 POKE 54276,32: REM STOP SOUND
5100 RETURN
6000 REM ******************** PRINT BACKGROUND ******************** 
6010 CB=14: REM CHARSET COPY MEMORY BLOCK 
6020 CC=CB*1024: REM CHARSET COPY MEMORY ADDRESS
6030 IF PEEK(CC) > 0 THEN GOTO 6140: REM CHECK CHARSET COPY MEMORY
6040 POKE 56334,PEEK(56334) AND 254: REM DEACTIVATE INTERRUPTS                    
6050 POKE 1,PEEK(1) AND 251: REM CONNECT CHARSET MEMORY                
6060 FOR X=0 TO 4095: POKE CC+X,PEEK(53248+X): NEXT X: REM COPY CHARSET MEMORY 
6070 POKE 1,PEEK(1) OR 4: REM DISCONNECT CHARSET MEMORY                                
6080 POKE 56334,PEEK(56334) OR 1: REM ACTIVATE INTERRUPTS                     
6090 POKE 53272,PEEK(53272) AND 240 OR CB: REM SET CHARSET MEMORY BLOCK
6100 FOR X=CC+(123*8) TO CC+(127*8)+7: READ Y: POKE X,Y: NEXT X: REM READ CHARS
6110 POKE 53270,PEEK(53270) OR 16: REM SET MULTICOLOR CHARACTER MODE
6120 POKE 53282,5: REM SET BACKGROUND GREEN COLOR
6130 POKE 53283,1: REM SET LINES WHITE COLOR
6140 FOR X=56096 TO 56295: POKE X,8: NEXT X: REM SET INDIVIDUAL COLOR
6150 FOR X=1824 TO 2023: POKE X,123: NEXT X: REM PRINT GREEN BACKGROUND 
6160 FOR X=1867 TO 1984 STEP 39: POKE X,124: NEXT X: REM LEFT LINE
6170 FOR X=1900 TO 2023 STEP 41: POKE X,125: NEXT X: REM RIGHT LINE
6180 FOR X=1828 TO 1859: POKE X,126: NEXT X: REM TOP LINE
6190 FOR X=1883 TO 2003 STEP 40: POKE X,127: NEXT X: REM CENTRAL LINE
6200 RETURN
10010 DATA 0,0,0,0,0,0,0,0,0,0,85,0,0,85,0,1
10020 DATA 105,64,1,105,64,5,170,80,5,170,80,6,170,144,6,170
10030 DATA 144,6,170,144,6,170,144,5,170,80,5,170,80,1,105,64
10040 DATA 1,105,64,0,85,0,0,85,0,0,0,0,0,0,0,131
10050 DATA 0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,21
10060 DATA 85,84,21,85,84,90,170,165,90,170,165,106,170,169,106,170
10070 DATA 169,106,170,169,106,170,169,90,170,165,90,170,165,21,85,84
10080 DATA 21,85,84,0,0,0,0,0,0,0,0,0,0,0,0,131
20000 DATA 85,85,85,85,85,85,85,85: REM BACKGROUND CHARACTER
20010 DATA 86,86,89,89,101,101,149,149: REM LEFT LINE CHARACTER
20020 DATA 149,149,101,101,89,89,86,86: REM RIGHT LINE CHARACTER
20030 DATA 85,85,85,85,85,85,170,170: REM TOP LINE CHARACTER
20040 DATA 86,86,86,86,86,86,86,86: REM CENTRAL LINE CHARACTER