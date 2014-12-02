LRJSAU3 ;ALB/GTS/DK - Lab Vista Audit Utilities - 2;03/31/2009
 ;;5.2;LAB SERVICE;**425**;Sep 27, 1994;Build 30
 ;
LRADDNOD(LRNODECT,LRCUR,LRPREV,LROUTPT,LRMMARY) ;Include Prev value in string and add to mail array.
 ; INPUT:
 ;   LRNODECT - Node number
 ;   LRCUR    - Current entry display
 ;   LRPREV   - Previous entry display
 ;   LROUTPT  - Type of array to populate (Display or Mail)
 ;   LRMMARY  - Array of output for Mail messages
 ;   
 ; OUTPUT:
 ;   Display array
 ; 
 N LRLGTH
 S:$G(LRPREV)="" LRPREV=""
 S:$G(LROUTPT)="" LROUTPT="DISPLAY"
 S:$G(LRMMARY)="" LRMMARY=""
 S LRLGTH=$L(LRCUR)
 S LRCUR=LRCUR_$J(LRPREV,3+$L(LRPREV)+(42-LRLGTH))
 D:LROUTPT="DISPLAY" ADD^LRJSAU(.LRNODECT,LRCUR)
 D:LROUTPT="MAIL" LRADDLNE(.LRNODECT,LRCUR,LRMMARY)
 Q
 ;
LRADDLNE(LRNODECT,MSG,LRMMARY) ; -- add line to build display
 ;INPUT:
 ;  LRNODECT - Node number
 ;  MSG      - Text to mail
 ;  LRMMARY  - Array for MailMan call
 ;
 ;OUTPUT:
 ;  Array for Mail message
 ;  
 S LRNODECT=LRNODECT+1
 S @LRMMARY@(LRNODECT)=MSG
 Q
