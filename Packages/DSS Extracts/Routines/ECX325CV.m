ECX325CV ;ALB/JAP  Patch ECX*3*25 Post Install Conversion ;May 21, 1999
 ;;3.0;DSS EXTRACTS;**25**;Dec 22, 1997
 ;
 N ECX,NODE,DATE,CASE,NON,TYPE,OPTIME,TIME,ECNO,A1,A2
 ;find every record in file #727.811 for fy1999
 S ECX=0
 F  S ECX=$O(^ECX(727.811,ECX)) Q:'ECX  S NODE=^ECX(727.811,ECX,0) I +$P(NODE,U,2)>199809 D
 .S CASE=+$P(NODE,U,10),TYPE=$P(NODE,U,17),NON=$P(NODE,U,32)
 .I NON]"" D
 ..S ECNO=$G(^SRF(CASE,"NON"))
 ..S A1=$P(ECNO,U,5),A2=$P(ECNO,U,4),TIME="##" D:(A1&A2) TIME S OPTIME=TIME
 ..I TYPE="P" S $P(^ECX(727.811,ECX,0),U,21)=OPTIME
 ..I TYPE'="P" S $P(^ECX(727.811,ECX,0),U,21)=""
 Q
 ;
TIME ; given date/time get increment
 ;A1=later, A2=earlier, TIME=difference
 S TIME=$TR($J($$FMDIFF^XLFDT(A1,A2,2)/900,6,0)," ") I TIME<0 S TIME="###"
 Q
