GMRAOR5 ;HIRMFO/WAA,FPT-OERR HL7 UTILITY ;3/5/04  14:02
 ;;4.0;Adverse Reaction Tracking;**4,12,13,19**;Mar 29, 1996
 ;MSG = HL7 Message array
 ;GMRANODE = IEN of MSG array
 ;GMRAND = Date from MSG(GMRANODE)
 ;GMRAMTP = Message type
 ;Allergy Loader
 ;building GMRAL Array to be used to stuff only new data
 ;GMRAID=sequence number of allergy
 ;~=continuation
 ;GMRAIDO = Sequence # OBSERVED
 ;GMRAIDS = Sequence # SIGN
 ;GMRAIDN = Sequence # NOTES
 ;   GMRADFN=DFN of patient in ^DPT(DFN) Patient (2) file
 ;   GMRAL(GMRAID)=type^file ien^VA Free text drug^file^OERR entry date
 ;                 ^NKA Status^Originator Pt to 200^Observed/Historical
 ;   GMRAL(GMRAID,"O",GMRAIDO)=Observed date^Severity^Observer's DUZ
 ;   GMRAL(GMRAID,"S",GMRAIDS)=IEN of file^Free Text of entry^File of SS
 ;                             ^Date/Time of the SS
 ;   GMRAL(GMRAID,"N",GMRAIDN)=Source of comments(Originator always)
 ;----------------------------------------------------------------------
 ;             Example of data
 ;   GMRADFN=270
 ;   GMRAL(1)="D^5^SHELL FISH^99ALL^2940415.06^n^1270^o"
 ;   GMRAL(1,"O",1)="2940401.1^3^1234"
 ;   GMRAL(1,"S",1)="32^SEVERE RASH^99ALS^2951211.1120"
 ;   GMRAL(1,"N",1)="n"
 ;   GMRAL(1,"N",1,1)=FREE TEXT
 ;******************************************************************
EN1 ;Main entry point to file data
 N %,GMRADUP,GMRAFDN,GMRANKA,GNRAY,X,Y
 Q:'$G(GMRADFN)
 S GMRAL=0
 S GMRAPA=0,GMRADUP=0
 ; See if the patient has been ask about allergies
 S (GMRAYN,GMRANKA)=0,GMRAYN=$P($G(^GMR(120.86,GMRADFN,0)),U,2)
 ;Loop through for each allergy
 F  S GMRAL=$O(GMRAL(GMRAL)) Q:GMRAL<1  D
 .;If GMRANKA="" add the entry into the file
 .I '$D(^GMR(120.86,GMRADFN,0)) K DD,DO,DIC,DINUM,DLAYGO S DIC="^GMR(120.86,",DLAYGO=120.86,DIC(0)="L",(DINUM,X)=GMRADFN D FILE^DICN K DD,DO,DIC,DINUM,DLAYGO D
 ..Q:Y=-1
 ..S GMRAYN=$S($P(GMRAL(GMRAL),U,6)="y":1,1:0)
 ..S $P(^GMR(120.86,GMRADFN,0),U,2,4)=GMRAYN_U_$P(GMRAL(GMRAL),U,7)_U_$P(GMRAL(GMRAL),U,5)
 ..Q
 .N GMRALL,GMRAFN,%
 .S GMRALL=$P(GMRAL(GMRAL),U,3)
 .I $P(GMRAL(GMRAL),U,6)="n" D  Q:GMRALL'=""
 ..; Change to no for allergies
 ..Q:GMRAYN="1"!$D(^GMR(120.86,GMRADFN,0))
 ..S $P(^GMR(120.86,GMRADFN,0),U,2,4)="0"_U_$P(GMRAL(GMRAL),U,7)_U_$P(GMRAL(GMRAL),U,5)
 ..S:'$D(^GMR(120.86,"B",GMRADFN,GMRADFN)) ^(GMRADFN)=""
 ..Q
 .I GMRAYN="0",$P(GMRAL(GMRAL),U,6)="n" Q
 .; see If the entry needs to be added
 .; If the entry is an allergy set 120.86 to "y"
 .I GMRALL'="",$D(^GMR(120.86,GMRADFN,0)) S GMRAYN=1 D
 ..; Change to yes for allergies
 ..S $P(^GMR(120.86,GMRADFN,0),U,2,4)=GMRAYN_U_$P(GMRAL(GMRAL),U,7)_U_$P(GMRAL(GMRAL),U,5)
 ..S:'$D(^GMR(120.86,"B",GMRADFN,GMRADFN)) ^(GMRADFN)=""
 ..Q
 .; Quit if the reaction is a Dup
 .Q:$$DUPCHK^GMRAOR0(GMRADFN,GMRALL)>0
 .S GMRAPA=0
 .K DD,DO,DIC,DINUM,DLAYGO S DIC="^GMR(120.8,",DLAYGO=120.8,DIC(0)="L",X=GMRADFN D FILE^DICN
 .K DD,DO,DIC,DINUM,DLAYGO
 .Q:Y=-1  S GMRAPA=+Y
 .Q:$G(^GMR(120.8,GMRAPA,0))=""
 .F  Q:$$LOCK^GMRAUTL(120.8,GMRAPA)
 .N GMRALN,GMRAVR
 .S GMRALN=$G(^GMR(120.8,GMRAPA,0))
 .S $P(GMRALN,U,4)=$P(GMRAL(GMRAL),U,5) ; Orig. DT
 .S $P(GMRALN,U,5)=$P(GMRAL(GMRAL),U,7) ; Originator
 .S %=$P(GMRAL(GMRAL),U,4),%=$S(%="99ALL"!(%="99OTH"):"GMRD(120.82,",%="99NDF":$P($$NDFREF^GMRAOR,U,2),%="99PSC":"PS(50.605,",1:"") Q:%=""  ;Bad entry
 .S:$P(GMRAL(GMRAL),U,2)="NOS" $P(GMRAL(GMRAL),U,2)=$S($O(^GMRD(120.82,"B","OTHER ALLERGY/ADVERSE REACTION",0))>0:$O(^GMRD(120.82,"B","OTHER ALLERGY/ADVERSE REACTION",0)),1:1)
 .S GMRAAR=$P(GMRAL(GMRAL),U,2)_";"_%,$P(GMRALN,U,3)=GMRAAR ;File Ptr
 .I $P(GMRAL(GMRAL),U,3)'="" S $P(GMRALN,U,2)=$P(GMRAL(GMRAL),U,3) ;Free text
 .E  D  ; This code will resolve the free text pointer for the reaction
 ..N GMRALOC,GMRADATA
 ..S GMRALOC="^"_$P($P(GMRALN,U,3),";",2)_+$P(GMRALN,U,3)_",0)"
 ..S GMRADATA=@GMRALOC
 ..S $P(GMRALN,U,2)=$P(GMRADATA,U)
 ..Q
 .S $P(GMRALN,U,20)=$P(GMRAL(GMRAL),U) ;Type of reaction
 .S $P(GMRALN,U,6)=$P(GMRAL(GMRAL),U,8) ;Obs/Hist
 .S $P(GMRALN,U,14)="U" ;Mechanism
 .S $P(GMRALN,U,12)=1 ;Sign-off the reaction
 .; auto-verify?
 .S GMRAVR="",GMRAVR(0)=GMRALN
 .S $P(GMRALN,U,16)=$$VFY^GMRASIGN(.GMRAVR)
 .I $P(GMRALN,U,16) S $P(GMRALN,U,17)=$$NOW^XLFDT
 .; save
 .S ^GMR(120.8,GMRAPA,0)=GMRALN
 .I $D(GMRAL(GMRAL,"S",1)) D SIGN^GMRAOR6(120.8,GMRAPA,.GMRAL) ; S/S
 .; Comments
 .I $D(GMRAL(GMRAL,"N",1)) D COMM^GMRAOR8(GMRAPA,.GMRAL) ; Add comments
 .D EN1^GMRAOR9 K GMRAAR ;stuff ingredients & classes
 .;Re-Index Whole file entry
 .K DIK,DA S DIK="^GMR(120.8,",DA=GMRAPA D IX^DIK K DIK,DA
 .D UNLOCK^GMRAUTL(120.8,GMRAPA)
 .S ^TMP($J,"GMRASF",1,GMRAPA)="" D RANGE^GMRASIGN(1) ;**19  Send bulletins upon signing-off
 .S GMRASITE(0)=$G(^GMRD(120.84,+GMRASITE,0)) D VAD^GMRAUTL1($P(^GMR(120.8,GMRAPA,0),U),"",.GMRALOC,.GMRANAM,"",.GMRASSN),BULLT^GMRASEND ;19 Send mark chart bulletin
 .Q:($P(GMRAL(GMRAL),U,1)'["D"!($P(GMRAL(GMRAL),U,8)'["o"))  ;quit if not an observed drug reaction
 .; add Adverse Reaction report.
 .I $G(GMRAL(GMRAL,"O",1))'="" D ADVERSE^GMRAOR7(GMRAPA,.GMRAL)
 .Q
 Q
