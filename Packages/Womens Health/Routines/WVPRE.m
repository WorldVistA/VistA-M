WVPRE ;HCIOFO/FT-Pre-Installation Routine ;9/16/98  13:06
 ;;1.0;WOMEN'S HEALTH;;Sep 30, 1998
 ;
 Q:'+$$VERSION^XPDUTL("BW")  ;IHS WH not installed
 Q:$D(^WV(790))  ;data transfer has been done already
 D COPY
 D NAME
 D REPAIR
 D FIELDS
 D CREDIT
 Q
COPY ; Copy data from IHS files into VISTA files.
 ; Does not delete IHS data.
 D BMES^XPDUTL("Copying data from IHS files to VISTA Women's Health files.")
 M ^WV(790)=^BWP
 M ^WV(790.01)=^BWMGR
 M ^WV(790.02)=^BWSITE
 M ^WV(790.03)=^BWPR
 M ^WV(790.04)=^BWPLOG
 M ^WV(790.05)=^BWEDC
 M ^WV(790.1)=^BWPCD
 M ^WV(790.2)=^BWPN
 M ^WV(790.31)=^BWDIAG
 M ^WV(790.32)=^BWRADX
 M ^WV(790.4)=^BWNOT
 M ^WV(790.403)=^BWNOTT
 M ^WV(790.404)=^BWNOTP
 M ^WV(790.405)=^BWNOTO
 M ^WV(790.5)=^BWCUR
 M ^WV(790.51)=^BWMAMT
 M ^WV(790.6)=^BWLET
 M ^WV(790.71)=^BWSNAP
 M ^WV(790.72)=^BWAGDF
 Q
NAME ; Change file name and number on zero node
 S WVX=789.9999
 F  S WVX=$O(^WV(WVX)) Q:'WVX  D
 .S WVNODE=$G(^WV(WVX,0))
 .S WVNAME=$P(WVNODE,U,1),WVNAME="WV"_$P(WVNAME,"BW",2)
 .S $P(WVNODE,U,1)=WVNAME
 .S WVNUMBER=$P(WVNODE,U,2),WVNUMBER="790"_$P(WVNUMBER,"9002086",2)
 .S WVNUMBER=WVNUMBER_$S(WVNUMBER["s":"",1:"s")
 .S $P(WVNODE,U,2)=WVNUMBER
 .S ^WV(WVX,0)=WVNODE
 .Q
 K WVX,WVNAME,WVNODE,WVNUMBER
 Q
REPAIR ; Do data repair/clean up
 D BMES^XPDUTL("Fixing data copied from IHS Women's Health files.")
 ; Change NEW status in File 790.1 to OPEN. NEW no longer exists.
 S WVIEN=0
 F  S WVIEN=$O(^WV(790.1,WVIEN)) Q:'WVIEN  D
 .Q:$P(^WV(790.1,WVIEN,0),U,14)'="n"
 .S $P(^WV(790.1,WVIEN,0),U,14)="o"
 .K ^WV(790.1,"S","n",WVIEN)
 .Q
 ; Change AGENCY value in File 790.02 to VA if not already VA
 S WVIEN=0
 F  S WVIEN=$O(^WV(790.02,WVIEN)) Q:'WVIEN  D
 .Q:$P(^WV(790.02,WVIEN,0),U,15)="v"
 .S $P(^WV(790.02,WVIEN,0),U,15)="v"
 .Q
 K WVIEN
 Q
FIELDS ; Set deleted fields values to ""
 ; Set Date Inactive (File 790, #.24) if patient is dead.
 ; Kill X-refs on deleted fields 
 ;   ---> File 790, fld# .2 ("CDC")
 ;   ---> File 790.1, fld# .17 "ACDC")
 S WVX=0 F  S WVX=$O(^WV(790,WVX)) Q:WVX'>0  D
 .S $P(^WV(790,WVX,0),U,20)=""
 .Q:$P(^WV(790,WVX,0),U,24)  ;Date Inactive exists
 .S WVDOD=$P($G(^DPT(WVX,.35)),U,1) ;date of death
 .Q:'WVDOD
 .S WVDOD=WVDOD\1
 .S $P(^WV(790,WVX,0),U,24)=WVDOD
 .Q
 K ^WV(790,"CDC") S WVX=0
 F  S WVX=$O(^WV(790.02,WVX)) Q:WVX'>0  D
 .F WVY=9,11,12,13,14,16,17,20 S $P(^WV(790.02,WVX,0),U,WVY)=""
 .F WVY=1,2,3,4,7,8,17:1:35,37,38 S $P(^WV(790.02,WVX,WVY),U,2)=""
 S WVX=0 F  S WVX=$O(^WV(790.1,WVX)) Q:WVX'>0  D
 .F WVY=3,16,17 S $P(^WV(790.1,WVX,0),U,WVY)=""
 .K ^WV(790.1,WVX,"PCC")
 .S WVQUAD=$P($G(^WV(790.1,WVX,2)),U,16)
 .K ^WV(790.1,WVX,2)
 .S:WVQUAD]"" $P(^WV(790.1,WVX,2),U,16)=WVQUAD
 .Q
 K ^WV(790.1,"ACDC")
 S WVX=0 F  S WVX=$O(^WV(790.2,WVX)) Q:WVX'>0  D
 .F WVY=12:1:17 S $P(^WV(790.2,WVX,0),U,WVY)=""
 S WVX=0 F  S WVX=$O(^WV(790.31,WVX)) Q:WVX'>0  D
 .F WVY=24:1:27 S $P(^WV(790.31,WVX,0),U,WVY)=""
 S WVX=0
 F  S WVX=$O(^WV(790.51,WVX)) Q:WVX'>0  D
 .S $P(^WV(790.51,WVX,0),U,2)=""
 .Q
 S WVX=0
 F  S WVX=$O(^WV(790.04,WVX)) Q:WVX'>0  D
 .F WVY=5,6 S $P(^WV(790.04,WVX,0),U,WVY)=""
 .Q
 S WVX=0
 F  S WVX=$O(^WV(790.05,WVX)) Q:WVX'>0  D
 .F WVY=5,6 S $P(^WV(790.05,WVX,0),U,WVY)=""
 .Q
 K WVDOD,WVQUAD,WVX,WVY
 Q
CREDIT ; Stuff Credit Method value from Radiology/NM
 ; "E" x-ref on File 790.1 is rad/nm date-case # (e.g., 060898-94)
 Q:'$D(^RADPT)  ;no Radiology/NM Patient file (#70)
 S WVX=""
 F  S WVX=$O(^WV(790.1,"E",WVX)) Q:WVX=""  S WVY=0 F  S WVY=$O(^WV(790.1,"E",WVX,WVY)) Q:'WVY  D
 .S WVNODE=$G(^WV(790.1,WVY,0)) Q:WVNODE=""
 .S WVDFN=$P(WVNODE,U,2) Q:WVDFN=""
 .D RADCHK
 .Q:WVCM=""  ;no credit method
 .S $P(^WV(790.1,WVY,0),U,35)=WVCM
 .Q
 K WVCASE,WVCM,WVDATE,WVDFN,WVNODE,WVX,WVY
 Q
RADCHK ; Get RAD/NM Patient Credit Method value
 S WVCM=""
 Q:'$D(^RADPT("ADC",WVX,WVDFN))  ;e.g., ^RADPT("ADC","060898-94",DFN))
 S WVDATE=0
 F  S WVDATE=$O(^RADPT("ADC",WVX,WVDFN,WVDATE)) Q:'WVDATE  S WVCASE=0 F  S WVCASE=$O(^RADPT("ADC",WVX,WVDFN,WVDATE,WVCASE)) Q:'WVCASE  D
 .S WVCM=$P($G(^RADPT(WVDFN,"DT",WVDATE,"P",WVCASE,0)),U,26)
 .Q
 K WVCASE,WVDATE
 Q
