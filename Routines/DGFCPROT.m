DGFCPROT ;FLB/ALB-DG Field Monitor cross-reference initialing routine. ;06/24/2010 10:51
 ;;5.3;Registration;**273,526,707,825**;AUG 13, 1993;Build 1
 ;
FC(DGDA,DGFILE,DGFIELD,DGTYPE,DGDTH,DGUSER,DGX,DGX1,DGX2,DGOPT) ; Field change listener
 ;Input: DGDA = DA array as exists during Fileman editing
 ;Input: DGFILE = File or subfile number where changed field resides
 ;Input: DGFIELD = Number of changed field
 ;Input: DGTYPE = Type of cross reference action ("SET" or "KILL")
 ;Input: DGDTH = date/time of change in $Horolog format
 ;Input: DGUSER = DUZ of user that made the change
 ;Input: DGX = X array as documented for Fileman new style x-refs
 ;Input: DGX1 = X1 array as documented for Fileman new style x-refs
 ;Input: DGX2 = X2 array as documented for Fileman new style x-refs
 ;Input: DGOPT = current option in "option_name^menu_text" format
 ;
 ;This utility invokes the DG FIELD MONITOR event point protocol.
 ;The DG variables as described above are made available to the
 ;subscribers of this event point.
 ;
 ;NOTE: This event point is not invoked if the action type is "KILL"
 ;      and the old field value is null or the new value is not null.
 ;      It is not invoked if the action type is "SET" and the new 
 ;      field value is null.
 ;
 Q:DGX=""  ;Quit if setting or killing null value
 ;
 I DGTYPE="KILL",DGX2]"" Q  ;Skip kill action on data update
 ;
 ;Manipulate DGTYPE value
 S DGTYPE=$S(DGTYPE="KILL":"DELETE",DGTYPE="SET":"ADD",1:DGTYPE)
 I DGX1]"",DGX2]"" S DGTYPE="UPDATE"
 ;
 S DGOPT=$P(DGOPT,U,1,2) S:DGOPT="" DGOPT="-1^Unknown"  ;Current option
 ; **825,MPIC_2114
 ;see if in reg option and save off values before getting into taskman task job and out of line with reg option
 I $$REG^VAFCDD01() D  Q
 .I (DGFIELD=994)!(DGFIELD=.525)!(DGFIELD=.0906)!(DGFIELD=.121)!(DGFIELD=.133)!(DGFIELD=.134) S VAFCFLDS(DGFIELD_";")=""
 .;The fields below ARE multiples
 .I DGFILE=2.01 S VAFCF="1;" S VAFCFLDS(VAFCF)="" ;ALIAS
 .I DGFILE=2.02 S VAFCF="2.02,.01;" S VAFCFLDS(VAFCF)="" ;RACE INFORMATION
 .I DGFILE=2.06 S VAFCF="2.06,.01;" S VAFCFLDS(VAFCF)="" ;ETHNICITY INFORMATION
 ;
 ;Task off (Taskman) driver routine.
 N ZTRTN,ZTDESC,ZTIO,ZTDTH,ZTSAVE,ZTSK,DGVAR,BXREF,SUBSCR,ZTREQ
 S ZTRTN="INIT^DGFCPROT",ZTDESC="DG Field monitor task"
 S ZTIO="DG FIELD MONITOR",ZTDTH=$$NOW^XLFDT
 F DGVAR="DGDA","DGDA(","DGFILE","DGFIELD","DGTYPE","DGDTH","DGUSER","DGX","DGX(","DGX1","DGX1(","DGX2","DGX2(","DGOPT" S ZTSAVE(DGVAR)=""
 ;If there are no subscribers, do not call Taskman
 I $D(VAFCA08) S ZTSAVE("VAFCA08")=VAFCA08 ;**707
 I $D(VAFHCA08) S ZTSAVE("VAFHCA08")=VAFHCA08 ;**707
 S BXREF=0,BXREF=$O(^ORD(101,"B","DG FIELD MONITOR",BXREF))
 S SUBSCR=0,SUBSCR=$O(^ORD(101,BXREF,10,SUBSCR))
 I 'SUBSCR Q
 D ^%ZTLOAD
 Q
 ;
INIT N X
 S X=$O(^ORD(101,"B","DG FIELD MONITOR",0))_";ORD(101," D EN1^XQOR
 I $D(ZTQUEUED) S ZTREQ="@"
 K DGDA,DGFILE,DGFIELD,DGTYPE,DGDTH,DGUSER,DGX,DGX1,DGX2,DGOPT
 Q
