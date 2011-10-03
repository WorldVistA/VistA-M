RGUTFTP ;CAIRO/DKM - FTP support (currently defined only for VMS);12-Oct-1998 15:49;DKM
 ;;2.1;RUN TIME LIBRARY;;Mar 22, 1999
 ;=================================================================
 ; Should not be invoked directly, but through a call to FTP^RGUTOS
 ;=================================================================
VMS(RGIP,RGMODE,RGSRCF,RGTGTF,RGTGTD,RGUSER,RGPASS) ;
 N RGZ,RGZ1,RGFIL,RGSRCD
 D HOME^%ZIS
 I IO=IO(0) D
 .U IO
 .I "@"[RGIP D
 ..S:RGIP="@" RGIP=$P($ZIO," ",2)
 ..I RGIP="" D  Q:RGIP=""
 ...R "Enter target IP address: ",RGIP:DTIME,!
 ...S:RGIP[U RGIP=""
 .I $G(RGSRCF)="" D  Q:RGSRCF=""
 ..R "Enter source file name : ",RGSRCF:DTIME,!
 ..S:RGSRCF[U RGSRCF=""
 .I $G(RGUSER)="" D  Q:RGUSER=""
 ..R "Enter target user name : ",RGUSER:DTIME,!
 ..S:RGUSER[U RGUSER=""
 .I $G(RGPASS)="" D  Q:RGPASS=""
 ..R "Enter target password  : ",RGPASS:DTIME,!
 ..S:RGPASS[U RGPASS=""
 D:$G(RGIP)="" RAISE^RGUTOS("No IP address")
 D:$G(RGSRCF)="" RAISE^RGUTOS("No source file")
 D:$G(RGUSER)="" RAISE^RGUTOS("No target user")
 D:$G(RGPASS)="" RAISE^RGUTOS("No target password")
 S RGZ=$S(RGMODE["G":"get ",RGMODE["P":"put ",1:""),RGSRCF=$TR(RGSRCF,"\","/"),RGSRCD=""
 S:RGSRCF["/" RGZ1=$L(RGSRCF,"/")-1,RGSRCD=$P(RGSRCF,"/",1,RGZ1)_"/",RGSRCF=$P(RGSRCF,"/",RGZ1+1)
 D:RGZ="" RAISE^RGUTOS("Mode not specified")
 W:IO=IO(0) !,"Beginning file transfer...",!!
 I $$NEWERR^%ZTER N $ET S $ET=""
 S @$$TRAP^RGUTOS("ERROR^RGUTFTP"),RGFIL="FTP"_$J_".TMP",RGMODE=$$UP^XLFSTR($G(RGMODE))
 D OPEN^RGUTOS(.RGFIL,"W")
 U RGFIL
 W:RGSRCD'="" $S(RGMODE["G":"cd ",1:"lcd ")_RGSRCD,!
 W:$G(RGTGTD)'="" $S(RGMODE["G":"lcd ",1:"cd ")_RGTGTD,!
 W $S($G(RGTGTF)="":"m"_RGZ_RGSRCF,1:RGZ_RGSRCF_" "_RGTGTF),!
 W:RGMODE["D"&(RGMODE["G") "mdelete "_RGSRCF,!
 W "quit",!
 D CLOSE^RGUTOS(.RGFIL)
 U IO
 S RGZ=$&ZLIB.%SPAWN("FTP "_RGIP_" /USER="""_RGUSER_"""/PASS="""_RGPASS_"""/INPUT="_RGFIL)
 D DELETE^RGUTOS(RGFIL)
 I RGMODE["P",RGMODE["D" D DELETE^RGUTOS(RGSRCF)
 Q
ERROR I IO=IO(0) D
 .U IO
 .W $$EC^%ZOSV,!!
 E  D ^ZTER
 Q
