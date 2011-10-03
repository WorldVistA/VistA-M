ONCOCRFA ;WASH ISC/SRR,MLH - FOLLOWUP XREF HELPER - UPDATE VITAL STATUS ;4/23/93  10:49
 ;;2.11;ONCOLOGY;;Mar 07, 1995
 Q  ;NOT A RUN ROUTINE
 ;
UVS ;    update vital status
 N VS,OVS,IC
 S VS=$P(LD,U,2),OVS=$P($G(^ONCO(160,XD0,1)),U) ;   get vital status (from follow-up), old vital status (from onco pat rec)
 I OVS'="" K ^ONCO(160,"AS",OVS,XD0) ;    kill old xref
 S $P(^ONCO(160,XD0,1),U)=VS ;    set new vital status
 I VS'="" S ^ONCO(160,"AS",VS,XD0)="" ;    set new xref
 ;
 D @$S(VS:"UVSALIVE",1:"UVSDEAD") ;    update patient fields depending on vital status
 QUIT
 ;
UVSALIVE ;    clear death fields for living patient
 N R1,L1
 S R1=$G(^ONCO(160,XD0,1)) ;    scalar node containing the death fields
 ;    clear fields 19,20,21,29,23,24,24.5,18.9,22.9,24.6
 F I=3,4,5,8,9,10,11,12,13,14 I $L($P(R1,U,I)) S $P(R1,U,I)=""
 ;    remove extraneous up-arrows
 F  S L1=$L(R1) Q:$E(R1,L1)'=U  S R1=$E(R1,1,L1-1)
 ;    reset node to the file
 S ^ONCO(160,XD0,1)=R1
 ;
 ;    clear path report WP node
 K ^ONCO(160,XD0,4)
 Q
 ;
UVSDEAD ;    update follow-up and date of death fields for dead patient
 N NF
 S NF=$P($G(^ONCO(160,XD0,1)),U,2),$P(^(1),U,2)="" ;    get & clear date of next f-u (field 27)
 I NF'="" K ^ONCO(160,"AD",NF,XD0) ;    kill f-u xref
 ;
 S $P(^ONCO(160,XD0,1),U,8)=$P(LD,U),$P(^(1),U,4)=9 ;    reset date@time of death and ICD revision (fields 29, 20)
 ;
 Q
