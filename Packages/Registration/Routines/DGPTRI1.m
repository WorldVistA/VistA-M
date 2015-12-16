DGPTRI1 ;ALB/MTC,HIOFO/FT - PTF VERIFICATION ;07/21/2015  7:14 AM
 ;;5.3;Registration;**850,884**;Aug 13, 1993;Build 31
 ;;Updated DGPTR1 for ICD-10 Transmission;;2/28/2012 - 850
 ;
 ;no external references
 ;
START ; Called from other DGPTRI* routines to do data validation and display errors
 ;How this validation works:
 ; Y is the segment (e.g., 101, 401) character string
 ; Figure out which segment it is. Characters 2 & 3 will be either 10, 40, 50, 53, 60 or 70. (i.e., T)
 ; Set ERR to a text line (e.g., T10) which has the field order and name in the segment. (e.g., 1:NAME)
 ; The patient name is the first field to be checked.
 ; Set W to a text line (e.g., 10) which has four numbers delimited by semi-colons for each "^" piece.
 ; Each "^" piece corresponds to a field in the segment string (Y). There can be more than one "^" piece 
 ; for each field.
 ; Set F to the first character of the segment to begin checking.
 ; The characters prior to 31 are "Control Data" values such as SSN and Admission Date/Time.
 ; DO L which loops through the various text lines such as T10 and 10 and validate the characters with
 ; pattern match code defined in the LOGIC subroutine.
 ; If the pattern match fails, the ERR subroutine is called and an error message is written to the screen.
 ; Finally, do any Dnn subroutines which have additional checks.
 ;
 Q:$E(Y,2,4)=702  ;come back to?
 S T=$E(Y,2,3) ;determine segment
 S ERR=$P($T(@("T"_T)),";;",2,999),W=$P($T(@(T)),";;",2,999),F=31 D L
 I T=70 S ERR=$P($T(T701),";;",2,999),W=$P($T(701),";;",2,999),F=73 D L
 D @("D"_T) Q
 K DGFILL
 Q
 ;
L ;
 ;$P(DG11,U,10) is FILE 2, Field .1173 which is COUNTRY [10P:779.004]
 N DGFOR S DGFOR=$S($$FORIEN^DGADDUTL($P(DG11,U,10))<1:0,1:1) ;set foreign country flag =1, else, set as domestic
 F H=1:1 S DGO=$P(W,U,H) Q:'DGO  D  ;find out how many values in the segment you want to validate
 . F Z=1:1:$P(DGO,";",3) D  ;Find out how many characters are in the value you want to validate
 .. S DGL=DGLOGIC(+DGO) ;get the pattern match needed to check the character(s)
 .. S X=$E(Y,F) ;get the character to validate
 .. D @("ERR:"_DGL) ;if the character fails the pattern match, call ERR to display a message
 .. S F=F+1 ;increment F to get the next character in the segment
 Q
 ;
 ;The Tnn lines have the SEQUENCE #:FIELD NAME for all of the fields in that segment.
 ;e.g., '1:NAME' is the patient NAME and it is the first field in the 101 segment. SOURCE OF ADM(ISSION) is the second and so on
 ; 101 segment
T10 ;;1:NAME^2:SOURCE OF ADM^3:TRANS FAC.^4:SOURCE OF PAY^5:POW^6:MARITAL ST^7:SEX^8:DOB^9:POS^10:VIETNAM^11:ION RADIATION^12:RESIDENCE^13:MEANS TEST^14:INCOME^15:MST^16:COMBAT VET^17:CV END DT^18:PROJ 112/SHAD^19:ERI^20:COUNTRY
 ; 701 segment (part 1)
T70 ;;1:DT OF DISP.^2:DISCH BD SEC^3:TYPE OF DIS^4:OUT TREAT^5:VA AUS^6:PL OF DIS^7:REC FAC^8:ASIH DAYS^9:RACE^10:C&P STAT^11:PDXLS^12:ONLY DX^13:PHY MPCR
 ; T701 segment (part 2)
T701 ;;1:PHY SPEC^2:%SC^3:LEGION^4:SUICIDE^5:DRUG^6:AXIS-IV^7:AXIS-V^8:SC^9:EXP^10:MST^11:HNC^12:ETHNICITY^13:RACE^14:COMBAT VET^15:PROJ 112/SHAD
 ; 501 segment
T50 ;;1:DT OF MVMT^2:LOSING BD SEC MPCR^3:LOSING BD SEC^4:LEAVE DAYS^5:PASS DAYS^6:SCI^7:DIAG^8:DOCTOR'S SSN^9:PHY MPCR^10:PHY SPEC^11:DISCHARGE STAT^^^^^16:LEGION^17:SUICIDE^18:DRUG^19:AXIS-IV^20:AXIS-V^21:SC^22:EXP^23:MST^24:HNC
 ; 535 segment
T53 ;;1:DATE OF PHYSICAL MOVEMENT^2:LOSING PHYSICAL MPCR^3:LOSING PHYSICAL SPECIALTY^4:TR SPECIALTY MPCR^5:TR SPECIALTY^6:LEAVE DAYS^7:PASS DAYS
 ; 401 segment
T40 ;;1:DATE OF SURGERY^2:SURG SPEC.^3:CAT CHIEF SURGEON^4:CAT FIRST ASS^5:ANEST. TECH.^6:SOURCE OF PAY^7:OP CODE
 ; 601 segment
T60 ;;1:DATE OF PROCEDURE^2:LOSING BD SEC^3:DIALYSIS TYPE^4:NUMBER OF TREATMENTS^5:PROCEDURE CODE
 ;
 ;LOGIC is a bunch of single or compound pattern matches delimited by an "^". A pattern match is used in the DGL variable
 ;in the L entry point above as a post-conditional value on the ERR subroutine. If the pattern match fails, then ERR is
 ;called to write an error message on the screen to the user. 
LOGIC ;;X'?.N^X'?.A&(X'=" ")^X'=" "^X'?.N&(X'=" ")^X'?.A&(X'=" ")^0^X'?.N&(X'="X")^X'=" "&(X'="P")^X="E"^X="Y"^X=" "^X'="A"&(X'=" ")^(X'?.A)&(X'?.N)&(X'=" ")^(X'?.AN)&('$P(DG0,U,4))^((T1)&(X'=" "))!(('T1)&(X'?.AN)&('$P(DG0,U,4)))
 ;;(X'?.AN)^'$D(DGFOR)&(X'?.N)^'$D(DGFOR)&X'?.N&(X'="X")^X'?AN&X'=""^"YNUW "']X
 ;;END
 ;
 ;The following nn lines are values used by the L entry point to validate the data.
 ;Each "^" piece contains for numbers delimited by semi-colons.
 ;The first number identifies the "^" piece in the LOGIC string to get the pattern match to use.
 ;The second number identifies the edit field. [need to elaborate on this more].
 ;The third number identifies the number of characters in the segment to check.
 ;The fourth number identifies the a piece in the Tnn string (above) to get the field name to display.
 ;i.e, in "10", the first "^" piece is 6;;12;1
 ;Use the pattern match in the sixth "^" of the LOGIC text line.
 ;The edit field is null because the patient name cannot be edited in the PTF software.
 ;12 represents the first 12 characters of the patient's last name that will be checked.
 ;1 represents the first "^" piece of the T10 text line (i.e., 1:NAME). NAME is the field name that will be displayed
 ;in the error message to the user.  
 ; edit check# ; edit field ; # x check preformed ; display error name #
 ; 101 segment
10 ;;6;;12;1^2;1;1;1^5;1;1;1^1;2;1;2^2;2;1;2^4;3;3;3^6;;3;3^4;4;1;4^6;5;1;5^2;6;1;6^2;7;1;7^1;8;8;8^6;;1;9^11;9;1;9^4;10;1;10^4;10;1;11^17;11;5;12^18;11;5;12^2;12;1;13^6;;1;13^1;;6;14^2;;1;15^1;;1;16^4;;6;17^1;;1;18^5;;1;19^5;;3;20
 ; 701 segment (part 1)
70 ;;1;1;10;1^13;2;2;2^1;3;1;3^4;4;1;4^4;5;1;5^6;;1;6^4;7;3;7^6;;3;7^4;8;3;8^6;9;1;9^1;10;1;10^6;11;1;11^6;11;2;11^6;;3;11^6;11;1;11^20;;1;11^6;;1;12^15;;6;13
 ; 701 segment (part 2)
701 ;;15;;2;1^1;;3;2^6;;1;3^6;;1;4^6;;1;5^6;;3;5^6;;1;6^6;;4;7^4;;1;8^5;;3;9^5;;1;10^5;;1;11^13;12;2;12^13;13;12;13^5;;1;14^5;;1;15
 ; 501 segment
50 ;;1;1;10;1^1;;6;2^16;3;2;3^1;4;3;4^1;5;3;5^6;;1;6^11;7;3;7^6;;197;7^6;;9;8^14;;6;9^14;;2;10^6;;1;11^6;;1;16^6;;1;17^6;;1;18^6;;3;18^6;;1;19^6;;4;20^6;;1;21^6;;3;22^5;;1;23^6;;1;24
 ; 535 segment
53 ;;1;;10;1^1;;6;2^13;;2;3^1;;6;4^13;;2;5^1;;3;6^1;;3;7
 ; 401 segment
40 ;;1;1;10;1^1;2;2;2^11;3;1;3^4;4;1;4^6;5;1;5^4;6;1;6^11;7;2;7^6;;200;7
 ; 601 segment
60 ;;1;1;10;1^13;2;2;2^4;3;1;3^4;4;3;4^11;5;2;5^6;;198;5
 ;
ERR S DGERR=1 ;if DGERR>0, the segment is not put in the mail message or ^TMP("AEDIT")
 W !,T,$S(T["H":" ",1:$E(Y,4)),"  "
 W:"45"[$E(T,1) $E(Y,31,32),"-",$E(Y,33,34),"-",$E(Y,35,36),"@",$E(Y,37,40) ;write date of procedure/dx code
 W ?25,$P($P(ERR,U,$P(DGO,";",4)),":",2),?40,"COL.",F,"  VALUE: ",$S($E(Y,F)=" ":"BLANK",1:$E(Y,F)) ;write field name,column postion and value
 S I=$S('$D(I):1,I>0:I,1:1),^(I)=$S($D(^UTILITY("DG",$J,T_$S(T["H":"",1:$E(Y,4)),I)):^(I),1:U) I $P(DGO,";",2),^(I)'[(U_$P(DGO,";",2)_U) S ^(I)=^(I)_$P(DGO,";",2)_U
 Q
 ;
D10 ;
 ;column 66 is PERIOD OF SERVICE, "Z" indicates Merchant Marines, "10" indicates VIETNAM (Agent Orange exposure)
 I $E(Y,66)="Z" S (F,H)=68,W="11;10;1;10" D L
 Q
 ;
D40 Q
DP40 Q
 ;
D70 ;column 43 is TYPE OF DISPOSTION, 44 is OUTPATIENT CARE STATUS
 ;In "W", 4 indicates OUTPATIENT TREATMENT, 5 indciates VA AUSPICES and 6 indicates PLACE OF DISPOSITION
 Q:$E(Y,2,4)=701
 I "467"'[$E(Y,43) S F=44,W="4;4;1;4^1;5;1;5^11;6;1;6" D L
 Q
D50 ;$P(DG0,U,5) is SUFFIX (File 45, field 5). column 55 is SPINAL CORD INJURY 
 I "A0"[$P(DG0,U,5)!("A4"[$P(DG0,U,5))!('$D(^DGPT(J,70))) S W="11;6;1;6",F=55 D L ;if $P(DG0,U,5) is null, this will execute
 I $D(^DGPT(J,70)),$S(T1:1,1:+^(70)>2871000) S W="11;6;1;6",F=55 D L
 ;I $E(Y,4)=1 S W="9;7;1;7",F=56 D L
 ; column 273 is BED STATUS (DISCHARGE MOVEMNT ONLY)
 I I=1,'T1 S W="1;11;1;11",F=273 D L
 Q
D53 Q
 ;column 43 is DIALYSIS TYPE, column 44 is NUMBER OF TREATMENTS and the 4 in "W" is also NUMBER OF TREATMENTS
D60 I $E(Y,43) S F=44,W="1;4;3;4" D L
 Q
 ;called from DGPTRI0
HEAD S ERR="1:SSN^2:ADMISSION DATE^3:FACILITY #",W="8;1;1;1^1;1;9;1^1;2;10;2^1;3;3;3^6;;3;3",F=5,T="HEADER" D LOG
 D L
 Q
LOG ;place DGLOGIC in array inorder to add more logic tests ;DG*5.3*664
 K DGLOGIC ;S DGLOGIC=$P($T(LOGIC),";;",2)
 N LOGX,LOGI,LOGCNT,II,XX
 S LOGI=0,LOGCNT=1
 F LOGI=0:1 S LOGX=$P($T(LOGIC+LOGI),";;",2) Q:LOGX="END"  F II=1:1 S XX=$P(LOGX,U,II) Q:XX=""  S DGLOGIC(LOGCNT)=XX,LOGCNT=LOGCNT+1
 Q
CEN ;called from 701^DGPTRI4
 S T=70,ERR=$P($T(T70),";;",2),W=$P($T(70),";;",2,999),W="6;9;1;9"_$P(W,"6;9;1;9",2,999),F=56 D L ;56 is RACE column
 S ERR=$P($T(T701),";;",2),W=$P($T(701),";;",2,999),F=73 D L
 Q
 ;
DIAGPTRN(DGDIAG) ; -- icd-10 diagnosis pattern match
 ;    1  2  3  4  5  6  7  8
 ;    -  -  -  -  -  -  -  -
 ;    U  N  U  .  U  U  N  U
 ;    X     N     N  N  x  N
 ;                x  x  n  n
 ;                n  n     
 N OKAY S OKAY=0
 I DGDIAG?1U1N1UN1".".4AN S OKAY=1
 Q OKAY
TEST ;
 W !,"F14. ",$$DIAGPTRN("F14.")
 W !,"G1G.1234 ",$$DIAGPTRN("G1G.1234")
 W !,"330. ",$$DIAGPTRN("330")
 W !,"R54.3XxY ",$$DIAGPTRN("R54.3XxY")
 W !,"R543XxY ",$$PROCPTRN("R543XxY")
 W !,"10.44 ",$$PROCPTRN("10.44")
 W !,"3S82B1 ",$$PROCPTRN("3S82B1")
 W !,"G23244X ",$$PROCPTRN("G23244X")
 Q
 ;
PROCPTRN(DGPROC) ;ICD-10 Procedure Code Pattern Match
 ; 
 ;    1  2  3  4  5  6  7
 ;    -  -  -  -  -  -  -
 ;    U  U  U  U  U  U  U
 ;    N  N  N  N  N  N  N
 ;       Z     Z  Z  Z  Z
 ; 
 N OKAY S OKAY=0
 I DGPROC?7UN S OKAY=1
 Q OKAY
