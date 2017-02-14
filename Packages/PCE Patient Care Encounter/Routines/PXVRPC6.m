PXVRPC6 ;SLC/AGP - PCE RPCs for generating IMM Note Text ;04/06/16  15:10
 ;;1.0;PCE PATIENT CARE ENCOUNTER;**215**;Aug 12, 1996;Build 10
 ;
 ;
GETTEXT(OUTPUT,INPUT) ;
 ;
 ; This RPC takes an input array of immunization properties set from the GUI.
 ; It returns a formatted text of an immunization for use in documentation.
 ;
 ;Input:
 ;   INPUT(x)=IMM ^ Imm IEN ^  ^ Date Administered (for immunizations) / Date Contra-Refusal Event Documented
 ;            (for contra/refusals) ^ Warn Until Date (for contra/refusals) ^ Series ^ Refusal reason ^
 ;            Contraindication Reason ^ Ordered By ^ Administered By (for VA administered) / Documented By
 ;            (for historical) ^ Document Type ("Historical"/"Administered") ^ Information Source
 ;   INPUT(x)=LOC ^ File #44 IEN ^  ^  ^ Outside Location (for historicals)
 ;   INPUT(x)=ROUTE ^ Route ^ Site ^ Dosage
 ;   INPUT(x)=VIS ^ VIS Name ^ Edition Date ^ Language
 ;   INPUT(x)=LOT ^ Lot # ^ Manufacturer ^ Exp Date
 ;   INPUT(x)=COM ^ Comment
 ;   INPUT(x)=OVER ^ Override Reason
 ;
 ;Returns:
 ;   Formatted text of an immunization for use in documentation.
 ;
 N ARRAY,COMMENT,DOCTYPE,I,IMM,J,NODE,OVERRIDE,TEMP,VISCNT,X0,XLOC,XLOT,XROUTE
 S (X0,XROUTE,XLOC,XLOT,COMMENT,OVERRIDE)=""
 S VISCNT=0
 S I=0
 F  S I=$O(INPUT(I)) Q:I'>0  D
 . S NODE=$G(INPUT(I))
 . I $P(NODE,U)="IMM" S X0=$P(NODE,U,2,99) Q
 . I $P(NODE,U)="LOC" S XLOC=$P(NODE,U,2,99) Q
 . I $P(NODE,U)="ROUTE" S XROUTE=$P(NODE,U,2,4) Q
 . I $P(NODE,U)="VIS" S VISCNT=VISCNT+1,ARRAY("VIS",VISCNT)=$P(NODE,U,2,99) Q
 . I $P(NODE,U)="LOT" S XLOT=$P(NODE,U,2,99) Q
 . I $P(NODE,U)="COM" S COMMENT=$P(NODE,U,2) Q
 . I $P(NODE,U)="OVER" S OVERRIDE=$P(NODE,U,2) Q
 ;
 S I=0
 ;
 S IMM=$P(X0,U,1)
 I 'IMM S OUTPUT(I)="" Q
 S I=I+1
 S OUTPUT(I)="IMMUNIZATION: "_$P($G(^AUTTIMM(IMM,0)),U,1)
 S J=0 F  S J=$O(^AUTTIMM(IMM,2,J)) Q:'J  D
 . S I=I+1
 . S OUTPUT(I)=$S(I=2:"FULL NAME: ",1:"")_$G(^AUTTIMM(IMM,2,J,0))
 ;
 S DOCTYPE=$P(X0,U,10)
 ;
 ;contraindacted or refused
 I $P(X0,U,6)'=""!($P(X0,U,7)'="") D  Q
 . I $P(X0,U,6)'="" S I=I+1,OUTPUT(I)="REFUSAL REASON: "_$P(X0,U,6)
 . I $P(X0,U,7)'="" S I=I+1,OUTPUT(I)="CONTRAINDICATION REASON: "_$P(X0,U,7)
 . I +$P(X0,U,4)>0 S I=I+1,OUTPUT(I)="WARN UNTIL: "_$TR($$FMTE^XLFDT($P(X0,U,4),"2ZM"),"@"," ")
 . I COMMENT'="" S I=I+1,OUTPUT(I)="COMMENT: "_COMMENT
 . S I=I+1,OUTPUT(I)="Date Documented: "_$TR($$FMTE^XLFDT($P(X0,U,3),"2ZM"),"@"," ")
 ;
 ;determine label depending on admin vs historical
 S TEMP=$S(DOCTYPE="Historical":"HISTORICAL DATE ADMINISTERED",1:"DATE ADMINISTERED")_": "_$TR($$FMTE^XLFDT($P(X0,U,3),"2ZM"),"@"," ")
 S I=I+1,OUTPUT(I)=$$LJ^XLFSTR(TEMP,60)
 I $P(X0,U,5)'="" S OUTPUT(I)=OUTPUT(I)_"SERIES: "_$P(X0,U,5)
 I $P(XLOT,U,2)'="" S I=I+1,OUTPUT(I)="MANUFACTURER: "_$P(XLOT,U,2)
 I $P(XLOT,U)'="" S I=I+1,OUTPUT(I)=$$LJ^XLFSTR("LOT: "_$P(XLOT,U),60)_"EXP DATE: "_$S($P(XLOT,U,3)'="":$P(XLOT,U,3),1:"Unknown")
 ;determine label depending on admin vs historical
 S TEMP=$S($P(XLOC,U)>0:"LOCATION: "_$P($G(^SC($P(XLOC,U),0)),U),$P(XLOC,U,4)'="":"OUTSIDE LOCATION: "_$P(XLOC,U,4),1:"")
 I TEMP'=""!($P(XROUTE,U,3)'="") D
 . S I=I+1,OUTPUT(I)=$$LJ^XLFSTR(TEMP,60)
 . I $P(XROUTE,U,3)'="" S OUTPUT(I)=OUTPUT(I)_"DOSAGE: "_$P(XROUTE,U,3)
 I $P(XROUTE,U)'="" S I=I+1,OUTPUT(I)="ADMIN ROUTE/SITE: "_$P(XROUTE,U)_"/"_$P(XROUTE,U,2)
 I $P(X0,U,11)'="" S I=I+1,OUTPUT(I)="INFORMATION SOURCE: "_$P(X0,U,11)
 I $D(ARRAY("VIS")) D
 . S I=I+1
 . S OUTPUT(I)="Vaccine Information Statement(s):"
 . S VISCNT=0 F  S VISCNT=$O(ARRAY("VIS",VISCNT)) Q:VISCNT'>0  D
 . . S NODE=$G(ARRAY("VIS",VISCNT))
 . . S I=I+1
 . . S OUTPUT(I)="VIS Name: "_$P(NODE,U)_", Edition Date: "_$TR($$FMTE^XLFDT($P(NODE,U,2),"2ZM"),"@"," ")_", Language: "_$P(NODE,U,3)
 I $P(X0,U,8)'="" S I=I+1,OUTPUT(I)="ORDERED BY: "_$P(X0,U,8)
 I $P(X0,U,9)'="" D
 . I DOCTYPE="Administered" S I=I+1,OUTPUT(I)="ADMINISTERED BY: "_$P(X0,U,9) Q
 . S I=I+1,OUTPUT(I)="DOCUMENTED BY: "_$P(X0,U,9)
 I COMMENT'="" S I=I+1,OUTPUT(I)="COMMENT: "_COMMENT
 I OVERRIDE'="" S I=I+1,OUTPUT(I)="OVERRIDE REASON: "_OVERRIDE
 Q
