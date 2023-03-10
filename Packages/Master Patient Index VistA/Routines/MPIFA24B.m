MPIFA24B ;BP/CMC-BUILD A24 ADD ME MSGS ; 5/4/20 10:59am
 ;;1.0;MASTER PATIENT INDEX VISTA;**22,28,31,25,43,44,51,61,68,75**;30 Apr 99;Build 1
 ;
 ; Integration Agreements Utilized:
 ;  START, EXC, STOP^RGHLLOG - #2796
 ;  BLDEVN, BLDPD1, BLDPID^VAFCQRY - #3630
 ;
A24(DFN,PID2,NOA31) ;BUILD AND SEND A24 **43 added PID2 as a parameter - not required.
 ; if PID2 is defined it will contain the previous ICN data, passed by reference
 ; **51 ADDED NOA31 as a parameter to stop the sending of an A31 if set to 1
 N RESLT,CNT,MPI,EVN,TCNT,ERR,PD1,PID
 K HLA("HLA"),HLA("HLS")
 S CNT=1
 D INIT^HLFNC2("MPIF ADT-A24 SERVER",.HL)
 I $O(HL(""))="" Q "-1^"_$P(HL,"^",2)
 S HLECH=HL("ECH"),HLFS=HL("FS"),COMP=$E(HL("ECH"),1),REP=$E(HL("ECH"),2),SUBCOMP=$E(HL("ECH"),4)
 S ERR="",TCNT=0
 D BLDEVN^VAFCQRY(DFN,"1,2",.EVN,.HL,"A24",.ERR)
 Q:ERR'="" ERR
 D BLDPID^VAFCQRY(DFN,1,"ALL",.PID,.HL,.ERR)
 Q:ERR'="" ERR
 D BLDPD1^VAFCQRY(DFN,"3",.PD1,.HL,.ERR)
 Q:ERR'="" ERR
 I '$D(PID2) D BLDPID^VAFCQRY(DFN,2,"ALL",.PID2,.HL,.ERR) ;**43 TO ONLY BUILD 2ND PID SEGMENT IF NOT PASSED
 Q:ERR'="" ERR
 S HLA("HLS",1)=EVN(1)
 S HLA("HLS",3)=PD1(1)
 S CNT=0 F  S CNT=$O(PID(CNT)) Q:CNT=""  D
 .I CNT=1 S HLA("HLS",2)=PID(CNT)
 .I CNT>1 S HLA("HLS",2,CNT-1)=PID(CNT)
 S CNT=0 F  S CNT=$O(PID2(CNT)) Q:CNT=""  D
 .I CNT=1 S HLA("HLS",4)=PID2(CNT)
 .I CNT>1 S HLA("HLS",4,CNT-1)=PID2(CNT)
 S HLA("HLS",5)=$$EN1^VAFHLZPD(DFN,"1,17,21,34") ;25 ;**44 Adding Pseudo SSN Reason, 1 and 21 to ZPD segment
 K HLL("LINKS")
 D GENERATE^HLMA("MPIF ADT-A24 SERVER","LM",1,.MPIFRSLT,"","")
 S RESLT=$S(+MPIFRSLT:MPIFRSLT,1:"-1^"_$P(MPIFRSLT,"^",3))  ;**68 Story 827754 (jfw) - Make Error Data Consistent (-1^msg)
 ;**68 Story 827754 (jfw) - Check for value < 0 instead of '+RESLT
 I +RESLT<0 S ^XTMP("MPIFA24%"_DFN,0)=$$FMADD^XLFDT(DT,5)_"^"_DT_"^"_"A24 message to MPI for DFN "_DFN,^XTMP("MPIFA24%"_DFN,"MPI",0)="A"
 K HLA,HLEID,HLL("LINKS"),COMP,REP,SUBCOMP,HLECH,HLFS,HLA("HLA"),HLA("HLS"),MPIFRSLT
 ;**44 TRIGGER A31 TO UPDATE ANY DEMOGRAPHIC CHANGES
 ;**51 IF NOT SENDING A31 STOP PROCESSING
 I $G(NOA31)=1 Q RESLT
 N A31 S A31=$$A31^MPIFA31B(DFN)
 I +A31<0 D
 .;log exception about A31 not being sent
 .D START^RGHLLOG()
 .D EXC^RGHLLOG(208,$P(A31,"^",2)_" : Unable to generate A31 for DFN "_DFN,DFN)  ;68, Story 827754 (jfw) - Combine error msgs as 1 param
 .D STOP^RGHLLOG(0)
 ;68, Story 827754 (jfw) - Remove redundancy as previously set in MPIFA31B.
 ;I $P(A31,"^",2)="" S ^XTMP("MPIFA31%"_DFN,0)=$$FMADD^XLFDT(DT,5)_"^"_DT_"^"_"A31 message to MPI for DFN "_DFN,^XTMP("MPIFA31%"_DFN,"MPI",0)="A"
 Q RESLT
 ;
RT ;
 S MPI=$$MPILINK^MPIFAPI()
 I $P($G(MPI),"^")=-1 D START^RGHLLOG(),EXC^RGHLLOG(224,"No logical link defined for the MPI",$G(DFN)),STOP^RGHLLOG() Q
 ;**75 - Story - 1260465 (ckn) - Include 200M in HLL links for HAC
 S HLL("LINKS",1)="MPIF ADT-A24 CLIENT^"_MPI_$S($P($$SITE^VASITE(),"^",3)=741:"^200M",1:"")
 Q
RES ;
 N NXT,DFN
 F NXT=1:1 X HLNEXT Q:HLQUIT'>0  D
 .I $E(HLNODE,1,3)="MSA" S DFN=$P($P(HLNODE,HL("FS"),7),"=",2)
 .I $E(HLNODE,1,3)="MSA"&($P(HLNODE,HL("FS"),4)'="") D
 ..; ERROR RETURNED IN MSA - LOG EXCEPTION --**44 stopped logging exception as MPI has already logged it.
 ..;D START^RGHLLOG(HLMTIEN,"","")
 ..;D EXC^RGHLLOG(208,$P(HLNODE,HL("FS"),4)_" for HL msg# "_HLMTIEN,DFN)
 ..;D STOP^RGHLLOG(0)
 K ^XTMP("MPIFA24%"_DFN)
 ;**61 Story 181213 (elz) let DG know A24 done
 K ^XTMP("DPTLK7 A24 IN-PROCESS",DFN)
 Q
