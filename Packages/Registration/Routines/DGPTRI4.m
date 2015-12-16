DGPTRI4 ;ALB/JDS/MJK/MTC/ADL/TJ/BOK,ISF/GJW,HIOFO/FT - PTF TRANSMISSION ;5/11/15 12:24pm
 ;;5.3;Registration;**850,884**;Aug 13, 1993;Build 31
 ;
 ; ^XMB(3.9) - #10066
 ; XLFSTR APIs - 10104
 ;
701 ; -- setup 701 transaction
 S Y=$$N701(J,T1)
 N K
 ;For Census records, send spaces for DISCHARGE SPECIALTY CODE (41-42), TYPE OF DISPOSITION (43), OUTPATIENT CARE STATUS (44),
 ;UNDER VA AUSPICES (45), PLACE OF DISPOSITION (46), RECEIVING FACILITY NUMBER (47-49), RECEIVING FACILITY
 ;SUFFIX (50-52), DXLS ONLY (66), PHYSICAL LOCATION CDR CODE (67-72) and PHYSICAL LOCATION CODE (73-74)
 I T1 F K=41:1:52,66:1:74 S $E(Y,K)=" "
 I T1 D CEN^DGPTRI1 D:'DGERR CSAVE ;S:'DGERR ^XMB(3.9,DGXMZ,2,DGCNT,0)=Y,DGCNT=DGCNT+1 Q
 I 'T1 D SAVE
 ;
702 ;create 702 only if there are secondary DXs
 Q:$G(DGRTY)=2  ;don't send 702 for census record
 Q:$$DXLSONLY^DGPTRNU1(J)  ;DXLS only (no secondary diagnoses)
 S Y=$$N702(J)
 D SAVE^DGPTRI2
 Q
 ;
POA(Y) ;-- Add POA to end of 101 segment with POA ;FT 3/23/15 - MAY NOT BE NEEDED
 N DGPOA,L,K S DGPOA=$G(^DGPT(J,82))
 S L=$P(DG70,U,10)_U_$P(DG70,U,16,24)_U_DG71
 F K=1:1:13 S Y=Y_$S($P(L,U,K)'="":$$POAVAL($P(DGPOA,U,K)),1:" ") ;6/18/2012 send what is stored per call with Dorothea Garrett.
 Q
 ;
POAVAL(POA) ; -- Convert POA indicator to a 1 or 0 for use in calculating DRG
 ; -- note:  Transmission of space " " if no corresponding DIAGNOSIS
 ; -- see POA^DGPTFD, same logic, different return values.
 S POA=$G(POA)
 ;
 ; -- On 8/9/2012 the ADT SME Determined that null POA should be defaulted to Yes
 ;    Due to the fact that the COTS PTF software was not uploading POA information.
 Q $S(POA="Y":"Y",POA="N":"N",POA="":"Y",POA="U":"U",POA="W":"W",1:"Y")
 ;
ENTER S Y=Y_$J($P(X,U,Z),L)
 Q
 ;
ENTER0 S Y=Y_$S($P(X,U,Z)]"":$E("00000",$L($P(X,U,Z))+1,L)_$P(X,U,Z),1:$J($P(X,U,Z),L))
 Q
 ;
SAVE ;validate data and save to MailMan message & ^TMP("AEDIT",$J)
 D SAVE^DGPTRI2
Q Q
 ;
CSAVE ;sets MailMan message, not ^TMP("AEDIT",$J)
 N DGY1,DGY2
 D FILL^DGPTRI2 ;fill out Y to 384 characters
 I $E(Y,2,4)=701 S DGY1=$E(Y,1,240),DGY2=$E(Y,241,384) D
 .S ^XMB(3.9,DGXMZ,2,DGCNT,0)=DGY1,DGCNT=DGCNT+1
 .S ^XMB(3.9,DGXMZ,2,DGCNT,0)=DGY2,DGCNT=DGCNT+1
 Q
CDR S Y=Y_$E($P(Z,".")_"0000",1,4)_$E($P(Z,".",2)_"00",1,2)
 Q
RTEN(X) ; This function will round X to the nearest multiple of ten.
 ; 0-4 ->DOWN; 5-9->UP
 Q (X\10)*10+$S(X#10>4:10,1:0)
 ;
ETHNIC(DGPTJ) ;Ethnicity (use first active value)
 ;Input - PTF ien
 ;Output - character string containing one ethnicity value and collection method
 N DGARRAY,DGNODE,DGNUM,DGETHNIC,DGLOOP,DGX,DGY
 M DGARRAY=^DPT(+^DGPT(DGPTJ,0),.06) ;get ETHNIC multiple from File 2
 S (DGETHNIC,DGY)="",DGLOOP=0,DGNUM=1
 F  S DGLOOP=+$O(DGARRAY(DGLOOP)) Q:'DGLOOP  D  Q:DGNUM>1
 .S DGNODE=$G(DGARRAY(DGLOOP,0))
 .Q:('DGNODE)!('$D(^DIC(10.2,+DGNODE,0)))  ;10.2=ETHNICITY file
 .Q:$$INACTIVE^DGUTL4(+DGNODE,2)  ;(VALUE,TYPE) where +DGNODE=ethnicity value and 2=ETHNICITY
 .S DGX=$$PTR2CODE^DGUTL4(+DGNODE,2,4) ;(VALUE,TYPE,CODE) where +DGNODE=ethnicity ien, 2=ETHNICITY and 4=PTF
 .S DGETHNIC=$S(DGX="":" ",1:DGX)
 .S DGX=$$PTR2CODE^DGUTL4(+$P(DGNODE,"^",2),3,4) ;(VALUE,TYPE,CODE) where $P(DGNODE,U,2)=ethnicity ien, 3=collection method ien and 4=PTF
 .S DGETHNIC=DGETHNIC_$S(DGX="":" ",1:DGX)
 .S DGNUM=DGNUM+1
 S DGY=DGY_$S(DGETHNIC="":"  ",1:DGETHNIC)
 Q DGY
 ;
RACE(DGPTJ) ;-- Race (use first 6 active values)
 ;Input - PTF ien
 ;Output - character string containing up to six race and collection methods
 N DGARRAY,DGNODE,DGNUM,DGRACE,DGI,DGK,DGX,DGY
 M DGARRAY=^DPT(+^DGPT(DGPTJ,0),.02) ;get RACE multiple from FILE 2
 S (DGRACE,DGY)="",DGI=0,DGNUM=1
 F  S DGI=+$O(DGARRAY(DGI)) Q:'DGI  D  Q:DGNUM>6
 .S DGNODE=$G(DGARRAY(DGI,0))
 .Q:('DGNODE)!('$D(^DIC(10,+DGNODE,0)))  ;10=RACE file
 .Q:$$INACTIVE^DGUTL4(+DGNODE)  ;(VALUE,TYPE) where +DGNODE=race value and 1=RACE (default is 1)
 .S DGX=$$PTR2CODE^DGUTL4(+DGNODE,1,4) ;(VALUE,TYPE CODE) where +DGNODE=race ien, 1=RACE and 4=PTF 
 .S DGRACE=DGRACE_$S(DGX="":" ",1:DGX)
 .S DGX=$$PTR2CODE^DGUTL4(+$P(DGNODE,"^",2),3,4) ;(VALUE,TYPE,CODE) where $P(DGNODE,U,2)=collection method ien, 3=COLLECTION TYPE and 4=PTF
 .S DGRACE=DGRACE_$S(DGX="":" ",1:DGX)
 .S DGNUM=DGNUM+1
 S DGX="" S $P(DGX," ",12)=""
 S DGRACE=$S(DGRACE="":"  ",1:DGRACE)_DGX
 S DGY=DGY_$E(DGRACE,1,12)
 Q DGY
 ;
N701(PTF,DGT1) ;create 701 segment
 N NODE,DFN,I,IENS,IENS2,X
 N NNAME ;node name
 N DTM,DDDIS,TDIS,DSPEC,TYDIS,PDIS,SA,X,I,RACEA,D1ONLY,DDATE,SC,SHAD
 N VAA,ASIH
 S DGT1=$G(DGT1) ;aka T1
 S NNAME=$S(DGT1:"C701",1:"N701")
 S IENS=PTF_","
 S DFN=$$GET1^DIQ(45,IENS,.01,"I"),IENS2=DFN_","
 S NODE=$$CDATA^DGPTRNU1(PTF,NNAME) ;control data
 S (DDATE,DTM)=$$DISP^DGPTRNU(PTF) ;date of disposition
 S DDIS=$$FDATE^DGPTRNU($P(DTM,".",1)) ;date in MMDDYY format
 S TDIS=$$TIME^DGPTRNU(DTM) ;time in HHMM format
 S:TDIS'?4N TDIS="0000" ;send zeros if time is blank
 S $E(NODE,31,36)=DDIS
 S $E(NODE,37,40)=TDIS
 S DSPEC=$$GET1^DIQ(45,IENS,71,"I") ;discharge specialty (pointer to file #42.4)
 S $E(NODE,41,42)=$$SPEC2PTF^DGPTRNU1(DSPEC) ;PTF code
 S $E(NODE,43)=$$TDIS^DGPTRNU1(PTF) ;type of disposition
 S $E(NODE,44)=$$GET1^DIQ(45,IENS,73,"I") ;outpatient care status
 S VAA=$$GET1^DIQ(45,IENS,74,"I")
 S $E(NODE,45)=$S(VAA=2:2,VAA=1:1,1:" ") ;VA auspices
 S $E(NODE,46)=$$PDIS^DGPTRNU(PTF) ;place of disposition
 S $E(NODE,47,49)=$$GET1^DIQ(45,IENS,76.1) ;receiving facility
 S $E(NODE,50,52)=$$GET1^DIQ(45,IENS,76.2) ;receiving facility suffix
 S ASIH=$$GET1^DIQ(45,IENS,77) ;asih days
 S ASIH=$S(ASIH>999:999,1:ASIH)
 S ASIH=$$JUSTIFY^DGPTRNU1(ASIH,3,"0","R")
 S $E(NODE,53,55)=$S(ASIH="000":"   ",1:ASIH) ;asih days
 S $E(NODE,56)="X" ;was race, but now is X
 S $E(NODE,57)=$$GET1^DIQ(45,IENS,78,"I") ;C&P status
 S $E(NODE,58,64)=$$FMTICD^DGPTRNU($$GET1^DIQ(45,IENS,79)) ;DXLS
 S $E(NODE,65)=$$GET1^DIQ(45,IENS,82.01,"I") ;POA for DXLS
 S D1ONLY=$$DXLSONLY^DGPTRNU1(PTF) ;DXLS only (no secondary diagnoses)
 S $E(NODE,66)=$S(D1ONLY:"X",1:" ")
 ;S X="",Z=+$O(^DGPT(PTF,535,"AM",$P(DDATE,".")-.0000001)) I $D(^DGPT(PTF,535,+$O(^(Z,0)),0)) S X=^(0) ;FT 4/1/15
 S X="",Z=+$O(^DGPT(PTF,535,"AM",DDATE-.0000001)) I $D(^DGPT(PTF,535,+$O(^(Z,0)),0)) S X=^(0) ;FT 4/1/15
 ;S DSPEC=$$GET1^DIQ(45,IENS,71,"I") ;discharge specialty
 S $E(NODE,67,72)=$$FMTMPCR^DGPTRNU1($P(X,U,16)) ;physical location CDR code
 S $E(NODE,73,74)=$$SPEC2PTF^DGPTRNU1($P(X,U,2)) ;physical location (specialty)
 S SC=$$GET1^DIQ(2,IENS2,.302) ;SC percentage
 S $E(NODE,75,77)=$$RJ^XLFSTR(SC,"3T",0) ;pad with leading zeros
 S $E(NODE,78)=" " ;Legionnaire's disease (not used)
 S $E(NODE,79)=" " ;suicide indicator (not used)
 S $E(NODE,80,83)=" " ;substance abuse (not used)
 ;positions 84-88 are not used with ICD-10
 S X=$$GET1^DIQ(45,IENS,79.25,"I") ;treated for SC condition
 S $E(NODE,89)=$S(X="Y":"Y",X="N":"N",1:" ")
 S $E(NODE,90)=$$AO^DGPTRNU(PTF) ;treated for AO condition
 S $E(NODE,91)=$$ION2^DGPTRNU(PTF) ;treated for ionizing radiation
 S $E(NODE,92)=$$SWASIA^DGPTRNU(PTF) ;treatment related to service in SW Asia
 S $E(NODE,93)=$$MST^DGPTRNU(PTF) ;treatment for/related to MST
 S $E(NODE,94)=$$HNC^DGPTRNU(PTF) ;treatment for HNC
 S $E(NODE,95,96)=$$ETHNIC(PTF) ;ethnicity
 S $E(NODE,97,108)=$$RACE(PTF) ;Up to 6 active entries for RACE INFORMATION
 S X=$$GET1^DIQ(45,IENS,79.31,"I")
 S $E(NODE,109)=$S(X="Y":"Y",X="N":"N",1:" ") ;related to combat
 S SHAD=$$SHAD^DGPTRNU(PTF) ;treatment for shad
 S $E(NODE,110)=$S(SHAD=1:"Y",SHAD=0:"N",1:" ") ;1=Yes, 0=No
 Q NODE
 ;
N702(PTF) ;create 702 segment
 N NODE,I,IENS,DGDX,DGLOOP,DGPOA,DGSTRING,DGPTTMP
 N NNAME ;node name
 N DTM,DDIS,TDIS,DXCODES,EFFDATE,IMPDATE
 S IENS=PTF_","
 S NNAME="N702"
 S NODE=$$CDATA^DGPTRNU1(PTF,NNAME) ;control data
 S DTM=$$GET1^DIQ(45,IENS,70,"I") ;date/time of discharge
 S DDIS=$$FDATE^DGPTRNU($P(DTM,".",1)) ;date in MMDDYY format
 S TDIS=$$TIME^DGPTRNU(DTM) ;time in HHMM format
 S:TDIS'?4N TDIS="0000" ;send zeros if time is blank
 S $E(NODE,31,36)=DDIS
 S $E(NODE,37,40)=TDIS
 D EFFDATE^DGPTIC10(PTF) ;get effective date to check icd version of dx codes
 D PTFICD^DGPTFUT(701,PTF,,.DXCODES) ;get secondary dx and poa values
 S DGLOOP=0,DGSTRING=""
 F  S DGLOOP=$O(DXCODES(DGLOOP)) Q:DGLOOP=""  D  ;ignore DXCODES(0). It is sent in 701 segment.
 .S DGPTTMP=$$ICDDATA^ICDXCODE("DIAG",$P(DXCODES(DGLOOP),U,1),EFFDATE,"I") ;get dx code info
 .I +DGPTTMP>0&($P(DGPTTMP,U,10)) D  ;check ien and status
 ..S DGDX=$P(DXCODES(DGLOOP),U,3) ;dx external value
 ..S DGDX=$$FMTICD^DGPTRNU(DGDX) ;remove decimal point
 ..S DGDX=$$LJ^XLFSTR(DGDX,7," ") ;left justify & add spaces to the right to reach 7 characters
 ..S DGPOA=$P(DXCODES(DGLOOP),U,2) ;get poa code
 ..S DGPOA=$S(DGPOA'="":DGPOA,1:" ") ;use space, if no POA code
 ..S DGSTRING=DGSTRING_DGDX_DGPOA ;build string of dx and poa values
 S $E(NODE,41,232)=DGSTRING_$$REPEAT^XLFSTR(" ",192-$L(DGSTRING))
 Q NODE
 ;
