LRSRVR4 ;DALOI/JMC -LAB DATA SERVER, CONT'D - UUENCODE UTILITY ; Dec 14, 2004
 ;;5.2;LAB SERVICE;**303**;Sep 27, 1994
 ;
 ;
UUEN(STR) ; Uuencode string passed in.
 N J,K,LEN,LRI,LRX,S,TMP,X,Y
 S TMP="",LEN=$L(STR)
 F LRI=1:3:LEN D
 . S LRX=$E(STR,LRI,LRI+2)
 . I $L(LRX)<3 S LRX=LRX_$E("   ",1,3-$L(LRX))
 . S S=$A(LRX,1)*256+$A(LRX,2)*256+$A(LRX,3),Y=""
 . F K=0:1:23 S Y=(S\(2**K)#2)_Y
 . F K=1:6:24 D
 . . S J=$$DEC^XLFUTL($E(Y,K,K+5),2)
 . . S TMP=TMP_$C(J+32)
 S TMP=$C(LEN+32)_TMP
 Q TMP
 ;
 ;
ENCODE(LRSTR) ; Encode a string, keep remainder for next line
 ; Call with LRSTR by reference, Remainder returned in LRSTR
 ;
 S LRQUIT=0,LRLEN=$L(LRSTR)
 F  D  Q:LRQUIT
 . I $L(LRSTR)<45 S LRQUIT=1 Q
 . S LRX=$E(LRSTR,1,45)
 . S LRNODE=LRNODE+1,^TMP($J,"LRDATA",LRNODE)=$$UUEN(LRX)
 . S LRSTR=$E(LRSTR,46,LRLEN)
 Q
