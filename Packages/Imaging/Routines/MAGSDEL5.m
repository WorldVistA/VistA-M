MAGSDEL5 ;WOIF/JSL - Delete the Not-Used Network Location w/ none ref of IMAGE ; 6/11/2010 10:12am
 ;;3.0;IMAGING;**98**;Mar 19, 2002;Build 1849;Sep 22, 2010
 ;; Per VHA Directive 2004-038, this routine should not be modified.
 ;; +---------------------------------------------------------------+
 ;; | Property of the US Government.                                |
 ;; | No permission to copy or redistribute this software is given. |
 ;; | Use of unreleased versions of this software requires the user |
 ;; | to execute a written test agreement with the VistA Imaging    |
 ;; | Development Office of the Department of Veterans Affairs,     |
 ;; | telephone (301) 734-0100.                                     |
 ;; | The Food and Drug Administration classifies this software as  |
 ;; | a medical device.  As such, it may not be changed in any way. |
 ;; | Modifications to this software may result in an adulterated   |
 ;; | medical device under 21CFR820, the use of which is considered |
 ;; | to be a violation of US Federal Statutes.                     |
 ;; +---------------------------------------------------------------+
 ;;
 Q
NETLOC(OUT,IN,PLACE,STEP) ;RPC - MAG UTIL CLNLOC
 ;NETWORK LOCATION 2005.2 to verify 0 reference of IMAGE file 2005
 ; OUT : result - code,message
 ; IN : delete network Location IEN
 ; PLACE : Site Parameter IN
 ; STEP : Heart beat (M2M)
 N ERR,I,IEN0,IEN,IEN9,NO,CNT,X0,XBIG,NO,N
 N NETLOC,PHY,NAME,TYP,TL,P
 K OUT S OUT(1)="-1",(ERR,TL)=0
 I ($G(IN)="")!'$G(PLACE) S OUT(1)="-1, No IEN or PLACE value." Q
 S IEN0=+$P(STEP,"#",1),IEN9=+$P(STEP,"#",2),CNT=IEN9-IEN0 S:CNT<1 CNT=1 ;;BEG#END
 F N=2:1 S NO=$P(IN,"^",N) Q:'NO  D      ;;Pre-check selected raid/jb entry
 . S X0=$G(^MAG(2005.2,NO,0))            ;;NO - ien of network location
 . I X0="" S OUT(1)="-1,Loc #"_IN_" not found",ERR=1 Q
 . S TYP=$P(X0,"^",7) ;storage type
 . I "MAG^WORM"'[$P(TYP,"-") S OUT(1)="-1,Not the 'MAG' or 'WORM' type location, but(#"_NO_"/"_TYP_")",ERR=1 Q
 . Q
 I ERR S OUT(1)=OUT(1)_",Network location file #2005.2 issue" Q
 S IEN=IEN0 F N=1:1 S IEN=$O(^MAG(2005,IEN)) Q:'IEN!(IEN>IEN9)  I N<CNT D
 . S X0=$G(^MAG(2005,IEN,0)),XBIG=$G(^MAG(2005,IEN,"FBIG"))
 . F N=2:1 S NO=$P(IN,"^",N) Q:'NO  D
 . . F P=3,4,5 I $P(X0,"^",P)=NO S ERR=1+ERR,TL=TL+1 S:TL<999 OUT(TL+1)="-1,Found IMAGE 2005 IEN "_IEN_" which has a reference to NETWORK LOCATION IEN "_NO_"("_$P($G(^MAG(2005.2,NO,0)),U)_")" Q
 . . F P=1,2 I $P(XBIG,"^",P)=NO S ERR=1+ERR,TL=TL+1 S:TL<999 OUT(TL+1)="-1,Found IMAGE 2005 IEN "_IEN_" 'FBIG' which has a reference to NETWORK LOCATION IEN "_NO_"("_$P($G(^MAG(2005.2,NO,0)),U)_")" Q
 . Q
 I ERR S OUT(1)="-1,Network location cleanup with #2005 IMAGE file reference issue" Q
 S IEN=IEN0 F N=1:1 S IEN=$O(^MAG(2005.1,IEN)) Q:'IEN!(IEN>IEN9)  I N<CNT D
 . S X0=$G(^MAG(2005.1,IEN,0)),XBIG=$G(^MAG(2005.1,IEN,"FBIG"))
 . F N=2:1 S NO=$P(IN,"^",N) Q:'NO  D
 . . F P=3,4,5 I $P(X0,"^",P)=NO S ERR=1+ERR,TL=TL+1 S:TL<999 OUT(TL+1)="-1,Found IMAGE Audit 2005.1 IEN "_IEN_" which has a reference to NETWORK LOCATION IEN "_NO_"("_$P($G(^MAG(2005.2,NO,0)),U)_")" Q
 . . F P=1,2 I $P(XBIG,"^",P)=NO S ERR=1+ERR,TL=TL+1 S:TL<999 OUT(TL+1)="-1,Found IMAGE Audit 2005.1 IEN "_IEN_" 'FBIG' which has a reference to NETWORK LOCATION IEN "_NO_"("_$P($G(^MAG(2005.2,NO,0)),U)_")" Q
 . Q
 I ERR S OUT(1)="-1,Network location cleanup with #2005.1 IMAGE Audit file reference issue" Q
 I (ERR=0)&(IEN0=IEN9) D  Q  ;;0 ref OF #2005 then cleanup
 . S OUT(1)=0_",Done "
 . F N=2:1 S NO=$P(IN,"^",N) Q:'NO  D DELOC(NO,PLACE) S:ERR=0 OUT(1)=OUT(1)_" #"_$P(IN,"^",N)
 . Q
 I ERR S OUT(1)=OUT(1)_", "_ERR
 S OUT(1)="1,NEXT#"_IEN Q  ;just to continue - RPC call, next IEN range step 
 Q
 ;
DELOC(NN,PLACE) ;
 ; NN: IEN of 2005.2
 ; PLACE : IEN of 2006.1
 N X,DA
 Q:$G(ERR)'=0  Q:+$G(NN)<1  Q:+$G(PLACE)<1
 D RLOC(NN)            ;FM delete
 S OUT(1)="0,Done "_$G(NN)
 Q
 ;
RLOC(NN) ; Delete Network Location file entry
 N DA,DIK,NAME,PHY,TYP
 S DA=NN I $D(^MAG(2005.2,DA,0)) D
 . S NAME=$P(^MAG(2005.2,DA,0),"^"),PHY=$P(^MAG(2005.2,DA,0),"^",2),TYP=$P(^MAG(2005.2,DA,0),"^",7)
 . S DIK="^MAG(2005.2,"
 . D ^DIK
 . I '$D(^MAG(2005.2,DA,0)),$D(^MAG(2005.2,"B",NAME,DA)) K ^MAG(2005.2,"B",NAME,DA)
 . I '$D(^MAG(2005.2,DA,0)),(TYP'="") I $D(^MAG(2005.2,"E",TYP,DA)) K ^MAG(2005.2,"E",TYP,DA)
 . I '$D(^MAG(2005.2,DA,0)),(PHY'="") I $D(^MAG(2005.2,"AC",PHY,DA)) K ^MAG(2005.2,"AC",PHY,DA)
 . D RAIDGR(DA)
 . K DIK,DA,NAME
 . Q
 Q
 ;
RAIDGR(IEN) ;
 ;IEN is the entry in file 2005.2 being deleted.
 ;This module checks if the duplicate entry is part of a RAID group and
 ;deletes the entry to prevent hanging pointers.
 N DIV,MAGIEN,DIK,DA
 Q:'+IEN
 S DIV=0 F  S DIV=$O(^MAG(2005.2,"F",DIV)) Q:'DIV  D:$D(^MAG(2005.2,"F",DIV,"GRP"))
 . S MAGIEN=0 F  S MAGIEN=$O(^MAG(2005.2,"F",DIV,"GRP",MAGIEN)) Q:'MAGIEN  D:$D(^MAG(2005.2,MAGIEN,7,"B",IEN,0))
 . . S DA=$O(^MAG(2005.2,MAGIEN,7,"B",IEN,0)) Q:'DA
 . . S DA(1)=MAGIEN,DIK="^MAG(2005.2,"_DA(1)_",7,"
 . . D ^DIK
 . . Q
 . Q
 Q
 ;
SHARE(MAGRY,TYPE) ;RPC [MAG UTIL GETNETLOC]
 ; Get list of current online/offline image shares
 ;TYPE = One of the STORAGE TYPE codes : MAG, EKG, WORM, URL or ALL
 N TMP,I,DATA0,DATA2,DATA3,DATA6,INFO,VALUE,STYP,PHYREF
 N $ETRAP,$ESTACK S $ETRAP="D ERRA^MAGGTERR"
 I TYPE="" S TYPE="ALL"
 S MAGRY(0)="1^SUCCESS"
 S I=0 F  S I=$O(^MAG(2005.2,I)) Q:'I  D
 . S DATA0=$G(^MAG(2005.2,I,0)) Q:'$L(DATA0)
 . S DATA2=$G(^MAG(2005.2,I,2))
 . S DATA3=$G(^MAG(2005.2,I,3))
 . S DATA6=$G(^MAG(2005.2,I,6))
 . S PHYREF=$P(DATA0,"^",2) ; PHYSICAL REFERENCE
 . S STYP=$P(DATA0,"^",7) ; STORAGE TYPE
 . I TYPE'="ALL" Q:STYP'[TYPE  ;filter by TYPE
 . S INFO=$S($E(PHYREF,$L(PHYREF))="\":$E(PHYREF,1,$L(PHYREF)-1),1:PHYREF)
 . S $P(INFO,"^",2)=$P($G(DATA0),"^",7) ;Physical reference (path)
 . S $P(INFO,"^",3)=$P($G(DATA0),"^",6) ;Operational Status 0=OFFLINE 1=ONLINE
 . S $P(INFO,"^",4)=$P($G(DATA2),"^",1) ;Username
 . S $P(INFO,"^",5)=$P($G(DATA2),"^",2) ;Password
 . S $P(INFO,"^",6)=$P($G(DATA6),"^",1)  ;MUSE Site #
 . I $P($G(DATA6),"^",2)'="" S $P(INFO,"^",7)=^MAG(2006.17,$P(DATA6,"^",2),0)  ;MUSE version #
 . S $P(INFO,"^",8)=$P($G(DATA3),"^",5)  ;Network location SITE
 . S $P(INFO,"^",9)=$P($G(DATA0),"^",10) ;PLACE #2006.1
 . S $P(INFO,"^",10)=$P($G(DATA0),"^",1) ;Name #2005.2
 . Q:$D(TMP(INFO))
 . S TMP(INFO)=I  ;ien #2005.2
 S INFO=""
 F  S INFO=$O(TMP(INFO)) Q:INFO=""  D  ;Sort by Physical Ref
 . S MAGRY($O(MAGRY(""),-1)+1)=TMP(INFO)_"^"_INFO
 K TMP
 Q
