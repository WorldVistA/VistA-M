RAMAGU11 ;HCIOFO/SG - ORDERS/EXAMS API (DEBUG UTILITIES) ; 1/31/08 9:34am
 ;;5.0;Radiology/Nuclear Medicine;**90**;Mar 16, 1998;Build 20
 ;
 Q
 ;
 ;***** WRITES VARIABLES AND THEIR VALUES
 ;
 ; ZZVLST        List of variables separated by commas
 ;
 ; [FLAGS]       Flags that control execution (can be combined):
 ;
 ;                 1  Each variable on a new line
 ;                 S  Skip a line before the output
 ;
VARS(ZZVLST,FLAGS) ;
 N ZZBUF,ZZI,ZZVAR
 S FLAGS=$G(FLAGS),ZZBUF=""
 D:FLAGS["S" W("","!")
 F ZZI=1:1  S ZZVAR=$$TRIM^XLFSTR($P(ZZVLST,",",ZZI))  Q:ZZVAR=""  D
 . I FLAGS'["1"  S:ZZI>1 ZZBUF=ZZBUF_"  "
 . S ZZBUF=ZZBUF_ZZVAR_"="
 . I '($D(@ZZVAR)#10)   S ZZBUF=ZZBUF_"<UNDEF>"
 . E  I +@ZZVAR=@ZZVAR  S ZZBUF=ZZBUF_@ZZVAR
 . E  S ZZBUF=ZZBUF_""""_@ZZVAR_""""
 . I FLAGS["1"  D W(ZZBUF,"!",IOM-10)  S ZZBUF=""
 D:FLAGS'["1" W(ZZBUF,"!",IOM-10)
 Q
 ;
 ;***** WRITES A LONG STRING
 ;
 ; STR           Text
 ;
 ; [FORMAT]      Format characters for the WRITE command. By default
 ;               ('$D(FORMAT)), "!" is assumed.
 ;
 ; [RM]          Right margin for the output. By default
 ;               ($G(RM)'>0), the (IOM-1) value is assumed.
 ;
W(STR,FORMAT,RM) ;
 N MAXWD
 S:'$D(FORMAT) FORMAT="!"
 S MAXWD=$S($G(RM)>0:RM,1:(IOM-1))-$P(FORMAT,"?",2)
 ;--- Write the first segment
 D PAGE^RAUTL22()
 W:FORMAT'="" @FORMAT  W $E(STR,1,MAXWD)
 ;--- Write remaining segments
 S FORMAT="!"_$TR(FORMAT,"!")
 F  S $E(STR,1,MAXWD)=""  Q:STR=""  D
 . D PAGE^RAUTL22()
 . W @FORMAT,$E(STR,1,MAXWD)
 Q
