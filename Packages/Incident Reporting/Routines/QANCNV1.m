QANCNV1 ;HISC/GJC-Conversion of data from V1.01 to V2.0 ;10/9/92
 ;;2.0;Incident Reporting;**1,4**;08/07/1992
CASE ;Building the case number from old IR data. (File: 513.72)
 S QANXIT=0,QAALPHA=99 ;SETS A PARAMETER FOR OUR CASE NUMBER i.e, "c"
 S QANMSSG="W !!,""Incomplete Incident Reporting data, for ^PRMQ(513.72,""_PRMQIEN_"",0)."",!,""Contact your site manager."",!!"
 S PRMQ0=$G(^PRMQ(513.72,PRMQIEN,0)),PRMQI=$G(^PRMQ(513.72,PRMQIEN,"I"))
 I PRMQ0']""!(PRMQI']"") S QANXIT=1
 I QANXIT S QANNON=$G(QANNON)+1 Q
 S PRMQ2=$G(^PRMQ(513.72,PRMQIEN,2)),PRMQPM=$G(^PRMQ(513.72,PRMQIEN,"PM"))
 S PRMQ5=$G(^PRMQ(513.72,PRMQIEN,5)),PRMQ8=$G(^PRMQ(513.72,PRMQIEN,8))
 S PRMQ1=$G(^PRMQ(513.72,PRMQIEN,1)),PRMQDISP=$P(PRMQ2,U,21)
 S PRMQME=$G(^PRMQ(513.72,PRMQIEN,"ME")),PRMQFF=$G(^PRMQ(513.72,PRMQIEN,"FF"))
 S PRMQMS=$G(^PRMQ(513.72,PRMQIEN,"MS")),PRMQAS=$G(^PRMQ(513.72,PRMQIEN,"AS"))
 S PRMQINC=$P($G(^PRMQ(513.941,+$P(PRMQI,U),0)),U),QANDATE=$P(PRMQ0,U)
 I PRMQINC']"" W !!,*7,"Bad pointer, incident type not found."
 I  W !,"Bad Node: ^PRMQ(513.72,"_PRMQIEN_",I)",! S QANXIT=1 Q:QANXIT
 D EN1^QANCNVT Q:QANXIT  ;Convert 'old' incidents to 'new' incidents.
 S PRMQYR=$E(QANDATE,2,3)_"0000",PRMQSTA=$P(QAQ0,U) ;QAQ0 set in 'CNV0'
 S PRMQST=$S($G(^DIC(4,PRMQSTA,99))]"":$P(^(99),U),1:PRMQSTA)
 S PRMQDFN=+$P($G(^QA(742.4,0)),U,3)+1
 F  Q:$D(^QA(742.4,PRMQDFN,0))=0  S PRMQDFN=PRMQDFN+1
 S QANCASE=PRMQST_$C(QAALPHA)_"."_(PRMQYR+PRMQDFN)
 ;Set up conversion fron 1.0 to 2.0
 S QANLOC0=$P(PRMQ0,U,15) ;Incident location
 S QANLOC1=$S(QANLOC0="PA":1,QANLOC0="BA":2,QANLOC0="HA":3,QANLOC0="TR":6,QANLOC0="NO":8,QANLOC0="ON":4,QANLOC0="OF":5,1:7)
 ;QANRPT - Pointer to file 3 (user), QANTREAT - pointer to file 45.7
 S QANRPT=$P(PRMQ0,U,6),QANTREAT=$P(PRMQ0,U,10)
 S QANWT=$S($P(PRMQ0,U,17)="WI":1,1:0) ;Witnessed?
 S QANLVL=$S($P(PRMQ5,U,3)="CA":1,$P(PRMQ5,U,3)="DE":3,$P(PRMQ5,U,3)="AD":2,$P(PRMQ5,U,3)="QA":3,1:"") ;Level of Review 11th piece 0 node, file 742.4
 S QANLVL(0)=$P(PRMQ5,U,3) ;Future 'local case status' check
 S QANMED=$S($P(PRMQ5,U)="PA":2,$P(PRMQ5,U)="ST":2,$P(PRMQ5,U)="EQ":3,1:"") ;Med Center action 2 node 742.4
 D DESC^QANCNV3 ;Grabbing other descriptive fields in 513.72
 I $D(^PRMQ(513.72,PRMQIEN,6)) D SERV^QANCNV2 ;Responsible Service
 S QANPAT=+$P(PRMQ0,U,2),QANNODE("PAT")=$G(^DPT(QANPAT,0))
 S:QANNODE("PAT")']"" QANXIT=1 X:QANXIT QANMSSG Q:QANXIT
 S QANPAT("NAME")=$P(QANNODE("PAT"),U) ;QANPAT("NAME") Patient's name
 S QANPAT("SSN")=$P(QANNODE("PAT"),U,9)
 S:QANPAT("SSN")]"" QANPAT("PT SSN")=$E(QANPAT("SSN"),6,9)
 S QANPAT("PT NAME")=$E($P(QANPAT("NAME"),",",2))_$E($P(QANPAT("NAME")," ",2))_$E(QANPAT("NAME"))
 I QANPAT("PT NAME")]"",QANPAT("PT SSN")]"" S QANPID=QANPAT("PT NAME")_QANPAT("PT SSN") ;Builds Patient ID
 S QANPTY=$S($P(PRMQ0,U,8)="IN":1,$P(PRMQ0,U,8)="OU"!($P(PRMQ0,U,8)="MI"):0,1:"")
 S QANWARD=+$P(PRMQ0,U,9),QANWARD=$G(^DIC(42,QANWARD,44)) ;Find ward, map 42 -> 44
 S QANSLEV=$S($P(PRMQ0,U,16)="MIT":1,$P(PRMQ0,U,16)="MIP":2,$P(PRMQ0,U,16)="MAT":2,$P(PRMQ0,U,16)="MAP":2,$P(PRMQ0,U,16)="POT":2,$P(PRMQ0,U,16)="DEA":3,$P(PRMQ0,U,16)="NO":0,1:"")
 Q
