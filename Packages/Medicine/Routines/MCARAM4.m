MCARAM4 ;WASH ISC/JKL-MUSE TRANSFER LAB DATA TO LOCAL ;5/20/94  15:35
 ;;2.3;Medicine;;09/13/1996
 ;
 ;
 ;Checks format and/or reformats data
AR(MCA,MCAA,MCD,MCFP,MCLP,MCCK) ;Sets l/t stripped data field into an array
 ; USAGE: S X=$$AR^MCARAM4(.A,B,C,D,E)
 ; WHERE: .A = array where data is placed
 ;         B = array argument for data field
 ;         C = data field value
 ;         D = first position of data field
 ;         E = last position of data field
 ;         F = 1 to check numeric data field value for positive int value
 ;             2 to check "" for both positive and negative int value
 ;             3 to check "" for pos,neg,int, and decimal values
 N MCI,MCERR
 I '$D(MCCK) S MCCK=""
 S MCA(MCAA)=$E(MCD,MCFP,MCLP),MCI=MCA(MCAA),MCERR=$$SLTS^MCARAM4(.MCI),MCA(MCAA)=MCI I +MCERR>0 Q MCERR
 I MCCK=1 S MCERR=$$DFCK^MCARAM4(MCA(MCAA),MCCK) I +MCERR>0 Q MCERR
 I MCCK=2 S MCERR=$$DFCK^MCARAM4(MCA(MCAA),MCCK) I +MCERR>0 Q MCERR
 I MCCK=3 S MCERR=$$DFCK^MCARAM4(MCA(MCAA),MCCK) I +MCERR>0 Q MCERR
 Q 0
 ;
DFCK(MCV,MCCK) ; Checks numeric,negative,positive,integer,decimal value
 ; USAGE: S X=$$DFCK^MCARAM4(A,B)
 ; WHERE: A=data field value
 ;        B=1 for positive value numeric (integer) check
 ;        B=2 for positive and negative value numeric (integer) check
 ;        B=3 for positive, negative, decimal, or integer numeric check
 ; if successful, returns function value of 0
 ; if unsuccessful, returns error message for incorrect field format
 N MCERR
 I MCV="" S MCERR="2-Null data field" Q MCERR
 I MCV=0 Q 0
 I $G(MCCK)=1 I MCV?1N.N Q 0
 I $G(MCCK)=2 I MCV?."-"1N.N,$P(MCV,"-",2,99)'["-",-MCV+-MCV'=0 Q 0
 I $G(MCCK)=3 I MCV?."-"."."1N.N.".".N,$P(MCV,".",2,99)'[".",$P(MCV,"-",2,99)'["-",-MCV+-MCV'=0 Q 0
 S MCERR="1-Data field not numeric" Q MCERR
 ;
SLTS(MCV) ; Strips leading and trailing spaces from data fields
 ; USAGE: S X=$$SLTS^MCARAM4(.A)
 ; WHERE: MCV=data field value
 ;       .A = value where data is placed
 ; if successful, returns function value of 0 and data field value
 ; if unsuccessful, returns error message for incorrect field format
 N MCERR,MCI,MCJ
 I MCV="" S MCERR="2-Null data field" Q MCERR
 F MCI=1:1 I $E(MCV,MCI,MCI)'=" " Q
 F MCJ=$L(MCV):-1 I $E(MCV,MCJ,MCJ)'=" " Q
 S MCV=$E(MCV,MCI,MCJ) I MCV="" S MCERR="2-Null data field" Q MCERR
 Q 0
 ;
DGCK(MCA) ;Removes null lines and resets numbering of diagnosis array
 ; USAGE: S X=$$DGCK^MCARAM4(.A)
 ; WHERE: MCA=diagnosis array
 ;       .A=diagnosis array renumbered without null lines
 ;        A("DX,0")=total number of non-null diagnosis lines
 ; if successful, returns function value of 0 and diagnosis array
 ; if unsuccessful, returns error message and A("DX,0")=0
 N MCI,MCJ,MCK,MCERR
 S MCI=0,MCJ="DX,0"
 F  S MCJ=$O(MCA(MCJ)) Q:MCJ=""!($E(MCJ)'=$E("DX,0"))  S:MCA(MCJ)'="" MCI=MCI+1 I MCA(MCJ)="" K MCA(MCJ) S MCK=MCJ F  S MCK=$O(MCA(MCK)) Q:MCK=""!($E(MCK)'=$E("DX,0"))  I MCA(MCK)'="" S MCA(MCJ)=MCA(MCK),MCI=MCI+1,MCA(MCK)="" Q
 S MCA("DX,0")=MCI I MCI>0 Q 0
 S MCERR="62-Diagnosis is a null data field" Q MCERR
 ;
RXCK(MCA) ;Removes null lines and resets numbering of medication array
 ; USAGE: S X=$$RXCK^MCARAM4(.A)
 ; WHERE: MCA=medication array
 ;        .A=medication array renumbered without null lines
 ;        A("RX,0")=total number of non-null medication lines
 ; if successful, returns function value of 0 and medication array
 ; if unsuccessful, returns error message and A("RX,0")=0
 N MCI,MCJ,MCK,MCERR
 I MCA("RX,0")="" S MCA("RX,0")=0,MCERR="4-Medication is a null data field" Q MCERR
 F MCJ=1:1 S MCK="RX,"_MCJ,MCA(MCK)=$P(MCA("RX,0"),", ",MCJ) Q:MCA(MCK)=""  S MCI=$P(MCA(MCK)," ") I MCI'="",$D(^PSDRUG("B",MCI)) S MCA(MCK)=$O(^(MCI,0))_U_$P(MCA(MCK)," ",2)_U_$P(MCA(MCK)," ",3)
 K MCA(MCK)
 S MCA("RX,0")=MCJ-1 I MCJ-1=0 S MCERR="4-Medication is a null data field" Q MCERR
 Q 0
 ;
DGCT(MCA,MCD,MCL) ;Fill diagnosis array from continuation record
 ; USAGE: S X=$$DGCT^MCARAM4(.A,B,C)
 ; WHERE: MCA=diagnosis array
 ;       .A=diagnosis array renumbered without null lines
 ;        B=data field value, C=line number of data
 ;        A("DX,0")=total number of non-null diagnosis lines
 ;        "DX,L"=12th line of diagnosis, "DX,V"=22nd line
 ; if successful, returns function value of 0 and diagnosis array
 ; if unsuccessful, returns error message and A("DX,0")=0
 N MCI,MCERR
 S MCI="DX,"_MCA("CONT")
 I MCL=13!(MCL=25) S MCERR=$$AR^MCARAM4(.MCA,MCI,MCD,32,78) Q:+MCERR>0 MCERR  Q 0
 S MCERR=$$AR^MCARAM4(.MCA,MCI,MCD,32,134) Q:+MCERR>0 MCERR
 Q 0
 ;
ERR ;Error return
 Q MCERR
