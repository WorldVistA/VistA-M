LR7OU0 ;slc/dcm - HL7 Utilities/Conversions ;8/11/97
 ;;5.2;LAB SERVICE;**121,187,265,299**;Sep 27, 1994
 ; Reference to ^DIC(9.4 supported by IA #2058
 ; Reference to ^SC( supported by IA #908
 ; Reference to ^VA(200 supported by SUPPORTED REFERENCE #10060
 ; Reference to ^XLFDT supported by IA #10103
 ;
EN ;
 Q
MSH(TYPE) ;Build MSH segment
 ;TYPE=Message type (ORM)
 N MSH
 S MSH="MSH|^~\&|LABORATORY|"_$G(DUZ(2))_"|||||"_TYPE
 Q MSH
PID(LRDPF) ; PID segment
 N PID
 S PID="PID|||"_$S($P(LRDPF,"^",2)="DPT(":+DFN,1:"")_"|"_+DFN_";"_$P(LRDPF,"^",2)_"|"_$P($G(@("^"_$P(LRDPF,"^",2)_+DFN_",0)")),"^")
 Q PID
PV1(LOC,ROOMBED,VISIT) ; PV1 segment
 ;TYPE = Patient Class (table 4)
 ;ROOMBED = Patient Room/Bed
 ;LOC = Patient Location
 ;VISIT = Visit Number
 N PV1,TYPE
 S TYPE=$S($P($G(^SC(+LOC,0)),"^",3)="W":"I",1:"O")
 S PV1="PV1||"_TYPE_"|"_LOC_"^"_ROOMBED_"||||||||||||||||"_$G(VISIT)
 Q PV1
HL7DT(DATE) ; FM -> HL7 format
 Q $$FMTHL7^XLFDT(DATE)
 ;N X
 ;S X="" I DATE S X=(1700+$E(DATE,1,3))_$E(DATE,4,7)_$E(DATE,9,14)
 ;Q X
FMDATE(DATE) ; HL7 -> FM format
 Q $$HL7TFM^XLFDT(DATE)
 ;N X
 ;S X="" I DATE S X=$E(DATE,1,4)-1700_$E(DATE,5,8)_$S($L($E(DATE,9)):"."_$E(DATE,9,14),1:"")
 ;Q X
NMSPACE(PKG) ; Returns pkg namespace
 N X S X=$P($G(^DIC(9.4,PKG,0)),"^",2)
 Q X
UVID(X,SPEC,NID,NSEC,NNAME,MSG,SS) ; Set Universal ID
 ;X=Test ptr to 60
 ;NID=National ID
 ;NNAME=National Name
 ;NSEC=National coding system
 ;SPEC=specimen ptr to file 61
 ;MSG=Message array to store data in
 ;SS=test subscript override, set when ORC is setup otherwise ""
 N X1,X3,X4,X6,XX
 S X3="LRT",X4=$P($G(^LAB(60,+$G(X),0)),"^"),X1=$P($G(^(0)),"^",4)
 S MSG=$S($L(MSG):MSG,X1="":"^TMP(""LRCH"",$J)","CYEMSPAU"[X1:"^TMP(""LRAP"",$J)",X1="BB":"^TMP(""LRBB"",$J)",X1="MI":"^TMP(""LRCH"",$J)",1:"^TMP(""LRCH"",$J)"),X3="LRT" ;$S(X1="BB":"LRB",1:"LRT")
 I '$D(@MSG@(1))#2 F I=1:1:4 I $D(MSG(I)) S @MSG@(I)=MSG(I)
 S XX=$S($L($G(SS)):$S(SS="BB":"LRBB",SS="CH":"LRCH",SS="MI":"LRMI",1:"LRAP"),1:"LRCH") I $D(ORCMSG),$L($G(MSG(ORCMSG))),$E(MSG(ORCMSG),1,3)="ORC" S X6=$P($P(MSG(ORCMSG),"|",4),"^"),$P(@MSG@(ORCMSG),"|",4)=X6_"^"_XX
 S X=NID_"^"_NNAME_"^"_NSEC_"^"_X_"^"_X4_"^99"_X3
 Q X
SAMP(SAMPLE,SPECIMEN) ; File 62,61 -> HL7 Source of Specimen code
 ;Sample=ptr to file 62
 ;Specimen=ptr to file 61
 N X
 S X=$G(^LAB(61,+SPECIMEN,0))
 S X=$P(X,"^",2)_";"_$P(X,"^")_";SNM;"_SAMPLE_";"_$P($G(^LAB(62,+SAMPLE,0)),"^")_";99LRS^^^"_+SPECIMEN_";"_$P(X,"^")_";99LRX"
 Q X
LRSAMP(SAMPLE) ;HL7 -> File 62 sample format
 ;Sample=Source of Specimen code
 N X
 S X=$P(SAMPLE,";",4)
 Q X
LRSPEC(SAMPLE) ;HL7 -> File 61 Specimen format
 ;Sample=Source of Specimen code
 N X
 S X="" I $P($P(SAMPLE,"^",4),";") S X=$P($P(SAMPLE,"^",4),";")
 I X="" S X=$S($L($P(SAMPLE,";")):$O(^LAB(61,"C",$P(SAMPLE,";"),0)),1:"")
 I X="",$P(SAMPLE,";",4) S X=$P($G(^LAB(62,$P(SAMPLE,";",4),0)),"^",2)
 Q X
ACTCODE(TYPE) ;Lab Collection type -> HL7 Specimen Action Code
 ;TYPE=WC, LC, SP, I, 3, A
 N X
 S X=$S(TYPE="SP":1,TYPE="WC":"O",TYPE="I":2,TYPE=3:3,TYPE="A":"A",1:"L")
 Q X
LRACTCOD(TYPE) ;HL7 Specimen Action Code -> Lab Collection type
 ;Type=1, 2, 3, A, O, L
 N X
 S X=$S(TYPE=1:"SP",TYPE=2:"I",TYPE=3:3,TYPE="A":"A",TYPE="O":"WC",1:"LC")
 Q X
URG(URGENCY) ;Lab Urgency -> HL7 Priority code
 ;URGENCY=Urgency ptr to Lab Urgency file
 ;X returned: HL7 code;ptr to lab urgency file (62.05) e.g.: "S;1" for STAT
 N X
 S X=$S($D(^LAB(62.05,+$G(URGENCY),0)):$P(^(0),"^",4),1:""),X=X_";"_URGENCY
 Q X
LRURG(URGENCY) ;HL7 Priority -> Lab Urgency
 ;URGENCY=HL7 Priority code
 N X
 S X=$P(URGENCY,";",2)
 Q X
FLAG(FLAG) ; Return HL7 Flag code
 ;FLAG=Test result flag
 N X
 S X=$S(FLAG="L":FLAG,FLAG="H":FLAG,FLAG="H*":"HH",FLAG="L*":"LL",1:"")
 Q X
