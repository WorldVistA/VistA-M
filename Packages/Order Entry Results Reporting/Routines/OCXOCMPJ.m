OCXOCMPJ ;SLC/RJS,CLA - ORDER CHECK CODE COMPILER (Build LIST Function Code cont...) ;10/29/98  12:37
 ;;3.0;ORDER ENTRY/RESULTS REPORTING;**32**;Dec 17,1997
 ;;  ;;ORDER CHECK EXPERT version 1.01 released OCT 29,1998
 ;
 Q
 ;
LAST(ROOT,ELEM,INDEX,PARAM,CD) ;
 ;
 Q:$G(OCXWARN) 1
 ;
 N VARNDX,VARVAL,VARCNT,VARLIM
 I '$L($G(ROOT)) D WARN^OCXOCMPV("'LAST' Function array root not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I '$L($G(ELEM)) D WARN^OCXOCMPV("'LAST' Function element not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I ($L(PARAM," ")>4) D WARN^OCXOCMPV("'LAST' Function with too many parameters.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 S VARNDX="OCXLX"_(+INDEX),VARVAL="OCXLV"_(+INDEX),VARCNT="OCXLC"_(+INDEX),VARLIM="OCXLB"_(+INDEX)
 ;
 I '$O(CD(0)),'$L(PARAM) D                     ;  SIMPLE
 .;
 .S CD(1)="; LAST SIMPLE"
 .S CD(2)="S "_VARNDX_"=$O("_ROOT_"""C"","_ELEM_",""""),-1) I "_VARNDX_" D @@@@ K "_VARNDX
 ;
 I '$O(CD(0)),($L(PARAM," ")=1),'($P(PARAM," ",1)=+$P(PARAM," ",1)) D              ;  FIELD NAME
 .N FIELD
 .S FIELD=$P(PARAM," ",1)
 .;
 .I '($E(FIELD,1)="|")!'($E(FIELD,$L(FIELD))="|") D  Q
 ..D WARN^OCXOCMPV("'LAST' Function field name missing in parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q
 .S FIELD=+$P(FIELD,"|",2)
 .;
 .S CD(1)="; LAST FIELD NAME"
 .S CD(2)="S "_VARVAL_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_",""""),-1) I $L("_VARVAL_") D  K "_VARVAL
 .S CD(3)=".S "_VARNDX_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_","_VARVAL_","_VARNDX_",""""),-1) I "_VARNDX_" D @@@@ K "_VARNDX
 ;
 I '$O(CD(0)),($L(PARAM," ")=1),($P(PARAM," ",1)=+$P(PARAM," ",1)) D              ;  RANGE OF INSTANCES
 .;
 .N VSTOP S VSTOP=+$P(PARAM," ",1)
 .;
 .S CD(1)="; LAST RANGE OF INSTANCES"
 .S CD(2)="S "_VARNDX_"="""" D  K "_VARNDX
 .S CD(3)=".F "_VARCNT_"=1:1:"_VSTOP_" S "_VARNDX_"=$O("_ROOT_"""C"","_ELEM_","_VARNDX_"),-1) I "_VARNDX_" D @@@@"
 ;
 ;  FIELD NAME AND RANGE OF INSTANCES
 ;
 I '$O(CD(0)),($L(PARAM," ")=2),'($P(PARAM," ",1)=+$P(PARAM," ",1)),($P(PARAM," ",2)=+$P(PARAM," ",2)) D
 .N FIELD,VSTOP
 .S FIELD=$P(PARAM," ",1),VSTOP=+$P(PARAM," ",2)
 .;
 .I '($E(FIELD,1)="|")!'($E(FIELD,$L(FIELD))="|") D  Q
 ..D WARN^OCXOCMPV("'LAST' Function field name missing in parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 .S FIELD=+$P(FIELD,"|",2)
 .;
 .S CD(1)="; LAST FIELD NAME AND RANGE OF INSTANCES"
 .S CD(2)="S ("_VARVAL_","_VARNDX_")="""","_VARCNT_"="_VSTOP_" D  K "_VARVAL_","_VARNDX_","_VARCNT
 .S CD(3)=".F  Q:'("_VARCNT_")  S "_VARVAL_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_",""""),-1) Q:'$L("_VARVAL_")  D"
 .S CD(4)="..F  Q:'("_VARCNT_")  S "_VARNDX_"="""
 .S CD(4)=CD(4)_" S "_VARNDX_"=$O("_ROOT_"""D"","_ELEM_","_VARVAL_","_VARNDX_"),-1) I "_VARNDX_" S "_VARCNT_"="_VARCNT_"-1 D @@@@"
 ;
 I '$O(CD(0)) D WARN^OCXOCMPV("'LAST' Function with invalid parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 ;
 Q OCXWARN
 ;
FIRST(ROOT,ELEM,INDEX,PARAM,CD) ;
 ;
 Q:$G(OCXWARN) 1
 I '$L($G(ROOT)) D WARN^OCXOCMPV("'FIRST' Function array root not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I '$L($G(ELEM)) D WARN^OCXOCMPV("'FIRST' Function element not defined.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 I ($L(PARAM," ")>4) D WARN^OCXOCMPV("'FIRST' Function with too many parameters.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 S VARNDX="OCXLX"_(+INDEX),VARVAL="OCXLV"_(+INDEX),VARCNT="OCXLC"_(+INDEX),VARLIM="OCXLB"_(+INDEX)
 ;
 I '$O(CD(0)),'$L(PARAM) D                     ;  SIMPLE
 .;
 .S CD(1)="; FIRST SIMPLE"
 .S CD(2)="S "_VARNDX_"=$O("_ROOT_"""C"","_ELEM_","""")) I "_VARNDX_" D @@@@ K "_VARNDX
 ;
 I '$O(CD(0)),($L(PARAM," ")=1),'($P(PARAM," ",1)=+$P(PARAM," ",1)) D              ;  FIELD NAME
 .N FIELD
 .S FIELD=$P(PARAM," ",1)
 .;
 .I '($E(FIELD,1)="|")!'($E(FIELD,$L(FIELD))="|") D  Q
 ..D WARN^OCXOCMPV("'FIRST' Function field name missing in parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q
 .S FIELD=+$P(FIELD,"|",2)
 .;
 .S CD(1)="; FIRST FIELD NAME"
 .S CD(2)="S "_VARVAL_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_","""")) I $L("_VARVAL_") D  K "_VARVAL
 .S CD(3)=".S "_VARNDX_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_","_VARVAL_","_VARNDX_","""")) I "_VARNDX_" D @@@@ K "_VARNDX
 ;
 I '$O(CD(0)),($L(PARAM," ")=1),($P(PARAM," ",1)=+$P(PARAM," ",1)) D              ;  RANGE OF INSTANCES
 .;
 .N VSTOP S VSTOP=+$P(PARAM," ",1)
 .;
 .S CD(1)="; FIRST RANGE OF INSTANCES"
 .S CD(2)="S "_VARNDX_"="""" D  K "_VARNDX
 .S CD(3)=".F "_VARCNT_"=1:1:"_VSTOP_" S "_VARNDX_"=$O("_ROOT_"""C"","_ELEM_","_VARNDX_")) I "_VARNDX_" D @@@@"
 ;
 ;  FIELD NAME AND RANGE OF INSTANCES
 ;
 I '$O(CD(0)),($L(PARAM," ")=2),'($P(PARAM," ",1)=+$P(PARAM," ",1)),($P(PARAM," ",2)=+$P(PARAM," ",2)) D
 .N FIELD,VSTOP
 .S FIELD=$P(PARAM," ",1),VSTOP=+$P(PARAM," ",2)
 .;
 .I '($E(FIELD,1)="|")!'($E(FIELD,$L(FIELD))="|") D  Q
 ..D WARN^OCXOCMPV("'FIRST' Function field name missing in parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 .S FIELD=+$P(FIELD,"|",2)
 .;
 .S CD(1)="; FIRST FIELD NAME AND RANGE OF INSTANCES"
 .S CD(2)="S ("_VARVAL_","_VARNDX_")="""","_VARCNT_"="_VSTOP_" D  K "_VARVAL_","_VARNDX_","_VARCNT
 .S CD(3)=".F  Q:'("_VARCNT_")  S "_VARVAL_"=$O("_ROOT_"""D"","_ELEM_","_FIELD_","""")) Q:'$L("_VARVAL_")  D"
 .S CD(4)="..F  Q:'("_VARCNT_")  S "_VARNDX_"="""
 .S CD(4)=CD(4)_" S "_VARNDX_"=$O("_ROOT_"""D"","_ELEM_","_VARVAL_","_VARNDX_")) I "_VARNDX_" S "_VARCNT_"="_VARCNT_"-1 D @@@@"
 ;
 I '$O(CD(0)) D WARN^OCXOCMPV("'FIRST' Function with invalid parameter list.",2,OCXD0,$P($T(+1)," ",1)) Q OCXWARN
 ;
 Q OCXWARN
