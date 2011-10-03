LAKERM3 ;SLC/RWF/DLG - UNPACK KERMIT RECORDS VIA LSI ;7/20/90  09:26 ;
 ;;5.2;AUTOMATED LAB INSTRUMENTS;;Sep 27, 1994
 ;Call with TSK = instrument
 ;Used to unpack kermit records from ^LA(tsk,"O",n) to ^LA(tsk,"C",n).
 ;See LAEKT7B for example of use.
A S:'$D(LAKDEM) LAKDEM=$C(13) S:'$D(LAKMAX) LAKMAX=124 S:'$D(^LA(TSK,"C")) ^LA(TSK,"C")=0,^("C",0)=0 S R1=^LA(TSK,"C"),R2="",LAKQCTL="#"
 F LOOP=0:0 D GET Q:LOOP!TOUT  D:'LAKERR @LATYPE,STORE
 Q
GET S LAKERR=0,OUT=""
 S CNT=^LA(TSK,"I",0)+1 IF '$D(^(CNT)) S TOUT=TOUT+1 Q:TOUT>9  H 10 G GET
 S ^LA(TSK,"I",0)=CNT,IN=^(CNT),TOUT=0
 S:$E(IN,$L(IN)-1)="~" CTRL=$P(IN,"~",2),IN=$P(IN,"~",1)
 S LATYPE=$E(IN,3) I "SYFDEBZ"'[$E(LATYPE_" ") S LAKERR=1 Q
 Q
S S OUT="" Q:$L(IN)'>8  S LAKQCTL=$E(IN,9),R1=^LA(TSK,"C") Q  ;Start of secion.
Y S LOOP=0,LAKERR=1 Q  ;Y records from download.
F S OUT="",R2="FILE:"_$E(IN,4,$L(IN)-1),R1=^LA(TSK,"C") D OUT Q  ;File header
D S OUT=$E(IN,4,$L(IN)-1) D:OUT[LAKQCTL QCTL Q
E S ^LA(TSK,"C")=R1,OUT="" Q  ;Error, discard data back to last good file
B ;End of transmision
Z S LOOP=1 D OUT:R2]"" Q
QCTL ;Unquote control's
 F I1=0:0 S I1=$F(OUT,LAKQCTL,I1) Q:I1<1  S X=$E(OUT,I1),C=$C($A(X)-32),OUT=$E(OUT,1,I1-2)_$S(X=LAKQCTL:X,1:C)_$E(OUT,I1+1,299)
 Q
STORE D OUT:$L(R2)+$L(OUT)>LAKMAX S R2=R2_OUT I R2[LAKDEM S OUT=$P(R2,LAKDEM,2,99),R2=$P(R2,LAKDEM,1)_LAKDEM D OUT S R2=OUT
 Q
OUT S CNT=^LA(TSK,"C")+1,^("C")=CNT,^("C",CNT)=R2,R2=""
 Q
