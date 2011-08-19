DGPTFVC1 ;ALB/AS/ADL - Expanded PTF Close-Out Edits ; 12/14/04 10:34am
 ;;5.3;Registration;**52,58,79,114,164,400,342,466,415,493,512,510,544,629,817**;Aug 13, 1993;Build 4
 ;;ADL;Updated for CSV Project;;Mar 26, 2003
 ;Called from Q+2^DGPTFTR. Variable must be passed in: PTF
 ;Variable returned: DGERR.   DGERR <-- 1 if record fails to pass a check; DGERR <-- "" if record passes all checks
 ;
 Q:'$D(PTF)
 S DGERR="",DGV(701)=$S($D(^DGPT(PTF,70)):^(70),1:""),DGV(101)=^(0),DGSUFFIX=$P(DGV(101),"^",5),DGV("FEE")=$P(DGV(101),"^",4),DFN=$P(DGV(101),"^",1)
 ;
 I $P(DGV(101),"^",2)>2820700 D AO
 ;
 I DGRTY=1,DGV("FEE") D MT
 ;
 ; DG*512, sck/Remove 101-Means Test indicator = 'U' xmit block
 ;I 'DGV("FEE"),$P(DGV(101),"^",10)="U",'DGV(701)!(+DGV(701)>2890700) S DGERR=1 W !,"101 MEANS TEST",?23," value 'U' - not valid for discharges as of 7/1/1989",!?42,"per MAS VACO policy"
 ;
 I $D(^DPT(DFN,57)),$P(^(57),"^",4)>0 S S0=$P(^(57),"^",4),DGDX=$S(S0=1!(S0=3):"344.1",1:"344.0"),DGSCI="" F DGX=0:0 S DGX=$O(^DGPT(PTF,"M",DGX)) Q:DGX'>0  S DGNODE=^(DGX,0),DGSCI="" D SCI
 ;
 S DGDP="",DGDISPO=$P(DGV(701),"^",6),DGRECSUF=$P(DGV(701),"^",13)
 I DGRTY=1 D
 .S DGSTATYP=$S(DGDISPO=12!(DGDISPO=13):30,DGDISPO=10:42,DGDISPO=8:40,1:"")
 .I DGSTATYP]"" D
 ..D NUMACT^DGPTSUF(DGSTATYP)
 ..I DGANUM>0 F I=1:1:DGANUM I DGSUFFIX=DGSUFNAM(I) D
 ...I DGDISPO'=8 I DGRECSUF=DGSUFNAM(DGANUM) S DGDP=5 D DP
 ...I DGDISPO=8 N DGANUM,DGSUFNAM D NUMACT^DGPTSUF(42) I DGRECSUF=DGSUFNAM(DGANUM) S DGDP=5 D DP
 .K DGANUM,DGSTATYP,DGSUFNAM,I
 ;
 I DGRTY=1 S %=$P(DGV(701),"^",3) I %=4!(%=6)!(%=7) S DGDP="" D OP I $P(DGV(701),"^",5)=1 S DGERR=1 W !,"701 VA AUSPICES",?23," value inconsistent for discharge"
 ;
 ;I 'DGV("FEE") S %=$P(^DPT(DFN,0),"^",6),%=$S($D(^DIC(10,+%,0)):$P(^(0),"^",2),1:"") I '%!(%>7) S DGERR=1 W !,"701 RACE",?23," value " W:%']"" "blank" I %]"" W %," (invalid code)"
 ;
 ;If PRRTP treating specialty, must have valid PRRTP suffix
 ;Fee records would not contain PRRTP specialties
 I 'DGV("FEE"),"^25^26^27^28^29^38^39^"[(U_$P(DGV(701),U,2)_U) D
 .I DGSUFFIX'="PA",(DGSUFFIX'="PB"),(DGSUFFIX'="PC"),(DGSUFFIX'="PD") D
 ..S DGERR=1
 ..W !,"101 SUFFIX",?23,"value must be set to a valid PRRTP suffix."
 ;
 D RACETHNC
 K DGDISPO,DGRECSUF,DGV,DGDP,DGDX,DGSCI,DGSUFFIX,DGNODE,DGX,%,S0,I,X
 I DGERR H 4
 Q
 ;
SCI F X=5:1:15 I X#10 S DGPTTMP=$$ICDDX^ICDCODE(+$P(DGNODE,"^",X),$$GETDATE^ICDGTDRG(PTF)) I +DGPTTMP>0&($P(DGPTTMP,U,10)) S:$E($P(DGPTTMP,"^",2),1,5)=DGDX DGSCI=1 Q:DGSCI
 I 'DGSCI S DGERR=1,%=$P(DGNODE,"^",10),X=$TR($$FMTE^XLFDT(%,"5DF")," ","0") W !,"501 ",X," SCI of ",S0,?23," requires an ICD Diagnosis code beginning with",!?12," or equal to ",DGDX
 Q
 ;
MT S DGVMT=$P(DGV(101),"^",10),DGX=999 G DGX:DGVMT']"" I +$P(DGV(101),"^",2)<2860700!(DGSUFFIX="BU") S DGX="X" G DGX
 ;S DGZEC=$S($D(^DPT(DFN,.36)):$P(^(.36),U,1),1:""),DGZEC=$S($D(^DIC(8,+DGZEC,0)):^(0),1:"") I $P(DGZEC,U,5)="N" S DGX="N" G DGX
 S DGZEC=$P($G(^DGPT(PTF,101)),U,8),DGZEC=$S($D(^DIC(8,+DGZEC,0)):^(0),1:"") I $P(DGZEC,U,5)="N" S DGX="N" G DGX
 S DGT=$P(DGV(701),".") G AS:'$O(^DGMT(408.31,"AD",1,DFN,0)) S DGZ1=$$LST^DGMTU(DFN,DGT) K:DGZ1']"" DGZ1
 I DGVMT="X" K DGX,DGVMT Q
 S DGX=$S('$D(DGZ1):"U",1:$P(DGZ1,U,4))
 ; Determine if the Pending Adjudication is for MT(C) or GMT(G)
 I DGX="P" D  G DGX
 . I '+$P($G(DGZ1),U) S DGX="U" Q
 . S DGX=$$PA^DGMTUTL($P(DGZ1,U)),DGX=$S('$D(DGX):"U",DGX="MT":"C",DGX="GMT":"G",1:"U")
 ; sc < 50%, 0% non-comp, sc movements - DG*5.3*544
 I DGX="A",$P(DGZEC,U,4)=3,$$SC^DGMTR(DFN),$$ANYSC^DGPTSCAN(PTF) S DGX="AS" G DGX
 ;-- sc, >0%  - DG*5.3*544
 I DGX="A","^1^3^"[("^"_$P(DGZEC,U,4)_"^"),$P($G(^DPT(DFN,.3)),U,2)>0 S DGX="AS" G DGX
 S DGX=$S(DGX="A":"AN","BCGN"[DGX:DGX,1:"U") G AS:DGX="U" G DGX:DGX'="N"
AS S DGZ=$S($D(^DPT(DFN,.321)):^(.321),1:0) I $P(DGZ,U,2)="Y"!($P(DGZ,U,3)="Y") S DGX="AS" G DGX
 S DGZ=$S($D(^DPT(DFN,.322)):^(.322),1:0) I $P(DGZ,U,13)="Y" S DGX="AS" G DGX
 N DGNTARR S DGZ=$S($$GETCUR^DGNTAPI(DFN,"DGNTARR")>0:DGNTARR("NTR"),1:"") I $P(DGZ,U)="Y" S DGX="AS" G DGX
 S DGZ=$$GETSTAT^DGMSTAPI(DFN) I $P(DGZ,U,2)="Y" S DGX="AS" G DGX
 I $P(DGZEC,U,5)="Y",$P(DGZEC,U,4)<4,"^2^15^"'[(U_$P(DGZEC,U,9)_U) S DGX="AS" G DGX
 S DGX="AN"
DGX ;DG*5.3*817/Remove 101-Means Test indicator = 'U' xmit block for FEE BASIS PTF 
 I DGVMT'=DGX,DGVMT'="U" S DGERR=1 W !,"101 ","MEANS TEST",?23," value ",DGVMT,$S(DGVMT']"":"blank",DGVMT="X":" only for admissions prior to 7/1/86 or domicilliary use",1:" inconsistent with eligibility data")
 K DGZEC,DGZ,DGZ1,DGT,DGX,DGVMT Q
 ;
DP I $P(DGV(701),"^",3)'=5 S DGERR=1 W !,"701 ",$E("TYPE OF DISPOSITION",1,18),?23," value inconsistent for discharge"
OP I $P(DGV(701),"^",4)=1 S DGERR=1 W !,"701 ",$E("OUTPATIENT TREATMENT",1,18),?23," value inconsistent for discharge" Q:DGDP=""
 I $P(DGV(701),"^",5)=2 S DGERR=1 W !,"701 VA AUSPICES",?23," value inconsistent for discharge"
 Q
 ;
AO I DGPTFMT<2 D  Q
 .S %=$S($D(^DGPT(PTF,101)):$P(^(101),"^",4),1:"")
 .S %=$S($D(^DIC(45.82,+%,0)):$P(^(0),"^",1),1:"")
 .S I=$S($D(^DPT(DFN,.321)):^(.321),1:"")
 .S:$P(I,"^",2)="Y"&(%'=6) DGERR=1,DGV("E")=1
 .W:$D(DGV("E")) !,"101 AGENT ORANGE",?23," value ",$S(DGV("E"):"can only be used with COB of '6'",1:"is inconsistent with Vietnam Service and/or COB")
 ;
 N AO,AOL,TMP
 S TMP=$G(^DPT(DFN,.321))
 S AO=$S($P(TMP,"^",2)="Y":1,1:0)
 S AOL=$P(TMP,"^",13)
 Q:('AO)
 Q:(AOL'="")
 S DGERR=1,DGV("E")=1
 W !,"101 AGENT ORANGE LOCATION",?23,"value required if exposure to Agent Orange claimed"
 Q
RACETHNC        ;Race and ethnicity check
 ;Ensure that a value for ethnicity and at least one race is on file.
 ;Ensure all active race/ethnicity values have a valid PTF value and an
 ;associated collection method.  Ensure all collection methods have a
 ;valid PTF value.  Ignore race/ethicity entries that are inactive or
 ;invalid pointers.  Note: PTF sends first active ethnicity and first
 ;six active races.
 N REF,IEN,TYPE,TEXT,PTRVAL,PTRMTHD,NUM,MAX
 N VALIDVAL,VALIDMTH,VALUE,VADM
 D DEM^VADPT
 F REF=11,12 D
 .I REF=12 D
 ..S MAX=6
 ..S TYPE=1
 ..S VALIDVAL=",3,8,9,A,B,C,D,"
 ..S VALIDMTH=",S,P,O,U,"
 ..S TEXT="RACE"
 .I REF=11 D
 ..S MAX=1
 ..S TYPE=2
 ..S TEXT="ETHNICITY"
 ..S VALIDVAL=",H,N,D,U,"
 ..S VALIDMTH=",S,P,O,U,"
 .S NUM=1
 .S IEN=0
 .F  S IEN=+$O(VADM(REF,IEN)) Q:'IEN  D  Q:NUM>MAX
 ..S PTRVAL=+VADM(REF,IEN)
 ..S PTRMTHD=+$G(VADM(REF,IEN,1))
 ..Q:'PTRVAL
 ..Q:$$INACTIVE^DGUTL4(PTRVAL,TYPE)
 ..S NUM=NUM+1
 ..S VALUE=$$PTR2CODE^DGUTL4(PTRVAL,TYPE,4)
 ..I (VALUE="")!(VALIDVAL'[VALUE) D  Q
 ...W !,"701 ",TEXT,?23,"missing/invalid xmit value"
 ...S DGERR=1
 ..I ('PTRMTHD) D  Q
 ...W !,"701 ",TEXT,?23,"method of collection missing/invalid"
 ...S DGERR=1
 ..S VALUE=$$PTR2CODE^DGUTL4(PTRMTHD,3,4)
 ..I (VALUE="")!(VALIDMTH'[VALUE) D  Q
 ...W !,"701 ",TEXT,?23,"missing/invalid xmit value for method of collection"
 ...S DGERR=1
 Q
