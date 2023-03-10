KMPSYNTH ;SP/JML - VistA Synthetic Transactions ;6/1/2020
 ;;4.0;CAPACITY MANAGEMENT;**1**;3/1/2018;Build 27
 ;
 ; Reference to ^DPT supported by ICR #10035
 ; Reference to PTSEC^DGSEC4 supported by ICR #3027
 ; Reference to GET^VPR supported by ICR #7135
 ; Reference to GET^VPRJD supported by ICR #7136
 ;
SYNRCMD(KMPJSON) ;
 N KMPA,KMPARRAY,KMPARRAY1,KMPB,KMPC,KMPEND,KMPI,KMPRET,KMPSTART
 S KMPSTART=$$STATS()
 F KMPI=1:1:1000 D
 .S KMPA=$R(100),KMPB=$R(100),KMPC=KMPA+KMPB,KMPARRAY(KMPI)=KMPC D
 ..M KMPARRAY1=KMPARRAY K KMPARRAY
 ..D ONE
 ..D TWO
 S KMPEND=$$STATS()
 S KMPJSON.SystemCpuTime=$P(KMPEND,"^",1)-$P(KMPSTART,"^",1)
 S KMPJSON.UserCpuTime=$P(KMPEND,"^",2)-$P(KMPSTART,"^",2)
 S KMPJSON.RoutineCommands=$P(KMPEND,"^",3)-$P(KMPSTART,"^",3)
 S KMPJSON.GlobalRefs=$P(KMPEND,"^",4)-$P(KMPSTART,"^",4)
 S KMPJSON.Runtime=$NUMBER(($P($P(KMPEND,"^",5),",",2)-$P($P(KMPSTART,"^",5),",",2))*1000,0)
 Q
 ;
ONE ;
 N KMPAAA,KMPANS1,KMPANS2,KMPANS3,KMPANS4,KMPANS5,KMPANS6,KMPARR,KMPBBB,KMPCCC,KMPX,KMPY,KMPZ
 S KMPAAA=$R(100),KMPBBB=$R(100),KMPCCC=$R(100)
 I KMPBBB=0 S KMPBBB=1000
 S KMPANS1=KMPAAA-KMPBBB S KMPANS1=$S(KMPANS1<1:1,1:KMPANS1)
 S KMPANS2=KMPAAA+KMPBBB S KMPANS2=$S(KMPANS2<1:1,1:KMPANS2)
 S KMPANS3=KMPAAA/KMPBBB S KMPANS3=$S(KMPANS3<1:1,1:KMPANS3)
 S KMPANS4=KMPAAA*KMPBBB S KMPANS4=$S(KMPANS4<1:1,1:KMPANS4)
 S KMPANS5=(KMPANS1/KMPANS2)*KMPANS3
 S KMPANS6=KMPANS4#2,KMPANS6=KMPANS1*KMPANS2*KMPANS3*KMPANS4
 F KMPX=1:1:100 D
 .F KMPY=1:1:100 D
 ..S KMPARR(KMPY)=KMPANS1*KMPANS2
 ..S KMPARR(KMPY,KMPY)=KMPANS3*KMPANS4
 ..S KMPARR(KMPY,KMPY,KMPY)=KMPANS1_"^"_KMPANS2_"^"_KMPANS3_"^"_KMPANS4
 S KMPZ=""
 F  S KMPZ=$O(KMPARR(KMPZ)) Q:KMPZ=""  D
 .K KMPARR(KMPZ)
 Q
 ;
TWO ;
 N KMPALPHA,KMPFIRST,KMPFL,KMPI,KMPLAST,KMPLEN,KMPSENTARR,KMPSENTENCE,KMPSENTENCE2,KMPTOT
 S KMPALPHA="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S KMPSENTENCE="THIS IS A ROUTINE TO GENERATE ROUTINE COMMANDS"
 S KMPLEN=$L(KMPSENTENCE," ")
 S KMPFIRST=$P(KMPSENTENCE," "),KMPLAST=$P(KMPSENTENCE," ",KMPLEN)
 S KMPFL=KMPFIRST_","_KMPLAST
 F KMPI=1:1:KMPLEN S KMPSENTARR(KMPI)=$P(KMPSENTENCE," ",KMPI)
 S KMPI=""
 F  S KMPI=$O(KMPSENTARR(KMPI)) Q:KMPI=""  D
 .S KMPSENTENCE2=$G(KMPSENTENCE2)_":"_$G(KMPSENTARR(KMPI))
 S KMPTOT=0 F KMPI=1:1:$L(KMPSENTENCE2) D
 .S KMPTOT=KMPTOT+$A($E(KMPSENTENCE2,KMPI))
 Q
 ;
SYNGBL(KMPJSON) ;
 N KMPALEN,KMPALPHA,KMPCHR1,KMPCHR2,KMPCNT,KMPEND,KMPGLO1,KMPGLO2,KMPI,KMPLEN1,KMPLEN2,KMPLINE,KMPNAME1,KMPNAME2,KMPSTART,KMPTEXT,KMPWORD1,KMPWORD2
 S KMPSTART=$$STATS()
 S KMPALPHA="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
 S KMPALEN=$L(KMPALPHA)
 F KMPCNT=1:1:1000 D
 .S KMPCHR1=$E(KMPALPHA,$R(KMPALEN)+1)
 .S KMPCHR2=$E(KMPALPHA,$R(KMPALEN)+1)
 .F KMPI=1:1:4 S $E(KMPNAME1,KMPI)=KMPCHR1
 .F KMPI=1:1:4 S $E(KMPNAME2,KMPI)=KMPCHR2
 .S KMPGLO1="^"_KMPNAME1_$J
 .S KMPGLO2="^"_KMPNAME2_$J
 .S KMPTEXT="",KMPLINE=1
 .F  D  Q:KMPTEXT=""
 ..S KMPTEXT=$P($TEXT(LOREM+KMPLINE),";;",2)
 ..S @KMPGLO1@("TEXT",KMPLINE)=KMPTEXT
 ..S KMPLINE=KMPLINE+1
 .S KMPI=""
 .F  S KMPI=$O(@KMPGLO1@("TEXT",KMPI)) Q:KMPI=""  D
 ..S KMPWORD1=$P(@KMPGLO1@("TEXT",KMPI)," ",3)
 ..S KMPWORD2=$P(@KMPGLO1@("TEXT",KMPI)," ",5)
 ..S KMPLEN1=$L(KMPWORD1)
 ..S KMPLEN2=$L(KMPWORD2)
 ..S @KMPGLO2@("TOT1")=$G(@KMPGLO2@("TOT1"))+KMPLEN1
 ..S @KMPGLO2@("TOT2")=$G(@KMPGLO2@("TOT2"))+KMPLEN2
 ..S @KMPGLO2@("PHRASE",KMPI)=KMPWORD1_"^"_KMPWORD2
 .K @KMPGLO1@("TEXT")
 .K @KMPGLO2@("TOT1"),@KMPGLO2@("TOT2"),@KMPGLO2@("PHRASE")
 S KMPEND=$$STATS()
 S KMPJSON.SystemCpuTime=$P(KMPEND,"^",1)-$P(KMPSTART,"^",1)
 S KMPJSON.UserCpuTime=$P(KMPEND,"^",2)-$P(KMPSTART,"^",2)
 S KMPJSON.RoutineCommands=$P(KMPEND,"^",3)-$P(KMPSTART,"^",3)
 S KMPJSON.GlobalRefs=$P(KMPEND,"^",4)-$P(KMPSTART,"^",4)
 S KMPJSON.Runtime=$NUMBER(($P($P(KMPEND,"^",5),",",2)-$P($P(KMPSTART,"^",5),",",2))*1000,0)
 Q
 ;
SYNFILE(KMPJSON) ;
 N KMPEND,KMPF,KMPFILE,KMPI,KMPLEN,KMPLINE,KMPSTART,KMPSTAT,KMPTEXT
 S KMPSTART=$$STATS()
 S KMPLEN="",KMPSTAT=""
 S KMPF=$$DEFDIR^%ZISH()_"loremipsem"_$J_".txt"
 S KMPFILE=##class(%File).%New(KMPF)
 D KMPFILE.Open("WSN")
 F KMPI=1:1:500 D
 .S KMPTEXT="",KMPLINE=1
 .F  D  Q:KMPTEXT=""
 ..S KMPTEXT=$P($TEXT(LOREM+KMPLINE),";;",2)
 ..D KMPFILE.WriteLine(KMPTEXT)
 ..S KMPLINE=KMPLINE+1
 S KMPLEN=KMPFILE.Size
 D KMPFILE.Close()
 S KMPSTAT=##class(%File).Delete(KMPF)
 S KMPEND=$$STATS()
 S KMPJSON.SystemCpuTime=$P(KMPEND,"^",1)-$P(KMPSTART,"^",1)
 S KMPJSON.UserCpuTime=$P(KMPEND,"^",2)-$P(KMPSTART,"^",2)
 S KMPJSON.RoutineCommands=$P(KMPEND,"^",3)-$P(KMPSTART,"^",3)
 S KMPJSON.GlobalRefs=$P(KMPEND,"^",4)-$P(KMPSTART,"^",4)
 S KMPJSON.Runtime=$NUMBER(($P($P(KMPEND,"^",5),",",2)-$P($P(KMPSTART,"^",5),",",2))*1000,0)
 Q
 ;
SYNVPR(KMPJSON,KMPDFN) ;
 N DT,KMPDARR,KMPEND,KMPI,KMPLAST,KMPLINE,KMPLINE2,KMPRET,KMPSTART,KMPTCHAR
 S KMPSTART=$$STATS()
 S DT=$$DT^XLFDT
 S KMPDARR=##class(%DynamicArray).%New()
 S KMPTCHAR=0,KMPI=0
 I $G(KMPDFN)="" S KMPDFN=$O(^DPT("A"),-1)
 D GET^VPRD(.KMPRET,KMPDFN)  ;  limit query - look at parameters (meds, documents, date range)
 S KMPLAST=$O(@KMPRET@(999),-1)
 F KMPI=1:1:KMPLAST D
 .S KMPLINE=$G(@KMPRET@(KMPI))
 .Q:KMPLINE=""
 .S KMPTCHAR=KMPTCHAR+$L(KMPLINE)
 .S $P(KMPLINE2,"X",$L(KMPLINE))="X"
 .D KMPDARR.%Push(KMPLINE2)
 .K KMPLINE2
 K @KMPRET
 S KMPJSON.Payload=KMPDARR
 S KMPJSON.TotalLines=KMPLAST
 S KMPJSON.TotalCharacters=KMPTCHAR
 S KMPJSON.Dfn=KMPDFN
 S KMPEND=$$STATS()
 S KMPJSON.SystemCpuTime=$P(KMPEND,"^",1)-$P(KMPSTART,"^",1)
 S KMPJSON.UserCpuTime=$P(KMPEND,"^",2)-$P(KMPSTART,"^",2)
 S KMPJSON.RoutineCommands=$P(KMPEND,"^",3)-$P(KMPSTART,"^",3)
 S KMPJSON.GlobalRefs=$P(KMPEND,"^",4)-$P(KMPSTART,"^",4)
 S KMPJSON.Runtime=$NUMBER(($P($P(KMPEND,"^",5),",",2)-$P($P(KMPSTART,"^",5),",",2))*1000,0)
 Q
 ;
PATLIST(KMPJSON,KMPMAX) ;
 ; LAST 4, LASTNAME, FIRSTMIDNAME, DUZ, last appointment
 N KMPPARR,KMPDFN,KMPCNT,KMPSTOP,DGSENS,DGSENFLG,KMPN0,KMPNAME,KMPLNAME,KMPFMNAME,KMPSSN,KMPLAST4,KMPSCDT,KMPPAT
 ;
 S KMPPARR=##class(%DynamicArray).%New()
 S KMPMAX=+$G(KMPMAX) I KMPMAX=0 S KMPMAX=10
 S KMPDFN="A",KMPCNT=0,KMPSTOP=0
 F  S KMPDFN=$O(^DPT(KMPDFN),-1) Q:KMPDFN=""!(KMPSTOP)  D
 .; Quit if patient is deceased
 .Q:$P($G(^DPT(KMPDFN,.35)),"^")]""
 .; Quit if patient is restricted
 .D PTSEC^DGSEC4(.DGSENS,KMPDFN)
 .Q:DGSENS(1)'=0
 .S KMPN0=$G(^DPT(KMPDFN,0))
 .S KMPNAME=$P(KMPN0,"^"),KMPLNAME=$P(KMPNAME,","),KMPFMNAME=$P(KMPNAME,",",2)
 .S KMPSSN=$P(KMPN0,"^",9),KMPLAST4=$E(KMPSSN,6,9)
 .S KMPSCDT=$O(^DPT(KMPDFN,"S",""),-1)
 .S KMPPAT=##class(%DynamicObject).%New()
 .S KMPPAT.SsnLast4=KMPLAST4,KMPPAT.LastName=KMPLNAME
 .S KMPPAT.FirstMiddleName=KMPFMNAME,KMPPAT.Dfn=KMPDFN
 .S KMPPAT.LastApptDate=$P($$TSTAMP^KMPUTLW(KMPSCDT,"FILEMAN"),"^")
 .D KMPPARR.%Push(KMPPAT)
 .S KMPCNT=KMPCNT+1
 .I KMPCNT>=KMPMAX S KMPSTOP=1
 S KMPJSON.Patients=KMPPARR
 Q
 ;
STATS() ;
 N KMPVCPU,KMPVPROC,KMPVRET
 S KMPVRET=""
 S KMPVPROC=##class(%SYS.ProcessQuery).%OpenId($J)
 I KMPVPROC="" Q KMPVRET
 ; cpu time
 S KMPVCPU=KMPVPROC.GetCPUTime()
 S $P(KMPVRET,"^")=$P(KMPVCPU,",")
 S $P(KMPVRET,"^",2)=$P(KMPVCPU,",",2)
 ; m commands - commands
 S $P(KMPVRET,"^",3)=KMPVPROC.CommandsExecuted
 ; global references
 S $P(KMPVRET,"^",4)=KMPVPROC.GlobalReferences
 ; current time UTC
 S $P(KMPVRET,"^",5)=$ZTIMESTAMP
 K KMPVPROC
 Q KMPVRET
 ;
LOREM ;
 ;;Lorem ipsum is a pseudo-Latin text used in web design, typography, 
 ;;layout, and printing  ;; in place of English to emphasise design 
 ;;elements over content. It's also called placeholder (or filler) 
 ;;text. It's a convenient tool for mock-ups. It helps to outline 
 ;;the visual elements of a document or presentation, eg typography, 
 ;;font, or layout. Lorem ipsum is mostly a part of a Latin text by 
 ;;the classical author and philosopher Cicero. Its words and letters 
 ;;have been changed by addition or removal, so to deliberately render 
 ;;its content nonsensical; it's not genuine, correct, or comprehensible 
 ;;Latin anymore. While lorem ipsum's still resembles classical Latin, 
 ;;it actually has no meaning whatsoever. As Cicero's text doesn't 
 ;;contain the letters K, W, or Z, alien to latin, these, and others 
 ;;are often inserted randomly to mimic the typographic appearence 
 ;;of European languages, as are digraphs not to be found in the original.
 ;;In a professional context it often happens that private or corporate 
 ;;clients corder a publication to be made and presented with the 
 ;;actual content still not being ready. Think of a news blog that's 
 ;;filled with content hourly on the day of going live. However, 
 ;;reviewers tend to be distracted by comprehensible content, say, a 
 ;;random text copied from a newspaper or the internet. The are likely 
 ;;to focus on the text, disregarding the layout and its elements. 
 ;;Besides, random text risks to be unintendedly humorous or offensive, 
 ;;an unacceptable risk in corporate environments. Lorem ipsum and its 
 ;;many variants have been employed since the early 1960ies, and quite 
 ;;likely since the sixteenth century. 
 ;;Lorem Ipsum: common examples layout based on Lorem Ipsum Most of 
 ;;its text is made up from sections 1.10.32-3 of Cicero's De finibus 
 ;;bonorum et malorum (On the Boundaries of Goods and Evils; finibus 
 ;;may also be translated as purposes). Neque porro quisquam est qui 
 ;;dolorem ipsum quia dolor sit amet, consectetur, adipisci velit is 
 ;;The first known version ("Neither is there anyone who loves grief 
 ;;itself since it is grief and thus wants to obtain it"). It was found 
 ;;by Richard McClintock, a philologist, director of publications at 
 ;;Hampden-Sydney College in Virginia; he searched for citings of 
 ;;consectetur in classical Latin literature, a term of remarkably 
 ;;low frequency in that literary corpus. Cicero famously orated 
 ;;against his political opponent Lucius Sergius Catilina. Occasionally 
 ;;the first Oration against Catiline is taken for type specimens: 
 ;;Quo usque tandem abutere, Catilina, patientia nostra? Quam diu 
 ;;etiam furor iste tuus nos eludet? (How long, O Catiline, will you 
 ;;abuse our patience? And for how long will that madness of yours 
 ;;mock us?) Cicero's version of Liber Primus (first Book), sections 
 ;;1.10.32-3 (fragments included in most Lorem Ipsum variants in red):
 ;;Cicero writing letters; from an early edition by Hieronymus Scotus 
 ;;Sed ut perspiciatis, unde omnis iste natus error sit voluptatem 
 ;;accusantium doloremque laudantium, totam rem aperiam eaque ipsa, 
 ;;quae ab illo inventore veritatis et quasi architecto beatae vitae 
 ;;dicta sunt, explicabo. Nemo enim ipsam voluptatem, quia voluptas sit, 
 ;;aspernatur aut odit aut fugit, sed quia consequuntur magni dolores 
 ;;eos, qui ratione voluptatem sequi nesciunt, neque porro quisquam est, 
 ;;qui dolorem ipsum, quia dolor sit amet, consectetur, adipisci[ng] 
 ;;velit, sed quia non numquam [do] eius modi tempora inci[di]dunt, ut 
 ;;labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima 
 ;;veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, 
 ;;nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure 
 ;;reprehenderit, qui in ea voluptate velit esse, quam nihil molestiae 
 ;;consequatur, vel illum, qui dolorem eum fugiat, quo voluptas nulla 
 ;;pariatur? 
 ;;Lorem Ipsum: translation
 ;;The Latin scholar H. Rackham translated the above in 1914:
 ;;De Finibus Bonorum Et Malorum But I must explain to you how all this 
 ;;mistaken idea of denouncing pleasure and praising pain was born and I 
 ;;will give you a complete account of the system, and expound the actual 
 ;;teachings of the great explorer of the truth, the master-builder 
 ;;of human happiness. No one rejects, dislikes, or avoids pleasure itself, 
 ;;because it is pleasure, but because those who do not know how to pursue 
 ;;pleasure rationally encounter consequences that are extremely painful. 
 ;;Nor again is there anyone who loves or pursues or desires to obtain pain 
 ;;of itself, because it is pain, but occasionally circumstances occur in 
 ;;which toil and pain can procure him some great pleasure. To take a 
 ;;trivial example, which of us ever undertakes laborious physical exercise, 
 ;;except to obtain some advantage from it? But who has any right to find 
 ;;fault with a man who chooses to enjoy a pleasure that has no annoying 
 ;;consequences, or one who avoids a pain that produces no resultant 
 ;;pleasure? On the other hand, we denounce with righteous indignation 
 ;;and dislike men who are so beguiled and demoralized by the charms of 
 ;;pleasure of the moment, so blinded by desire, that they cannot foresee 
 ;;the pain and trouble that are bound to ensue; and equal blame belongs 
 ;;to those who fail in their duty through weakness of will, which is the 
 ;;same as saying through shrinking from toil and pain. These cases are 
 ;;perfectly simple and easy to distinguish. In a free hour, when our 
 ;;power of choice is untrammelled and when nothing prevents our being able 
 ;;to do what we like best, every pleasure is to be welcomed and every pain 
 ;;avoided. But in certain circumstances and owing to the claims of duty 
 ;;or the obligations of business it will frequently occur that pleasures 
 ;;have to be repudiated and annoyances accepted. The wise man therefore 
 ;;always holds in these matters to this principle of selection: he 
 ;;rejects pleasures to secure other greater pleasures, or else 
 ;;he endures pains to avoid worse pains.
 ;;Lorem Ipsum: variants and technical information
 ;;Adobe Fireworks Lorem Ipsum plugin In 1985 Aldus Corporation launched 
 ;;its first desktop publishing program Aldus PageMaker for Apple Macintosh 
 ;;computers, released in 1987 for PCs running Windows 1.0. Both contained 
 ;;the variant lorem ipsum most common today. Laura Perry, then art director 
 ;;with Aldus, modified prior versions of Lorem Ipsum text from typographical 
 ;;specimens; in the 1960s and 1970s it appeared often in lettering 
 ;;catalogs by Letraset. Anecdotal evidence has it that Letraset used Lorem 
 ;;ipsum already from 1970 onwards, eg. for grids (page layouts) for ad 
 ;;agencies. Many early desktop publishing programs, eg. Adobe PageMaker, 
 ;;used it to create template. Most text editors like MS Word or Lotus 
 ;;Notes generate random lorem text when needed, either as pre-installed 
 ;;module or plug-in to be added. Word selection or sequence don't 
 ;;necessarily match the original, which is intended to add variety. 
 ;;Presentation software like Keynote or Pages use it as a samples for 
 ;;screenplay layout. Content management software as Joomla, Drupal, Mambo, 
 ;;PHP-Nuke, WordPress, or Movable Type offer Lorem Ipsum plug-ins 
 ;;with the same functionality.
 ;;DONE
