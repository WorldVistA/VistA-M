GMRCP96 ;ABV/SCR - Post-Install Routine for patch 96 ;12/8/17 07:36
 ;;3.0;CONSULT/REQUEST TRACKING;**96**;DEC 27;Build 21; 1997;Build 1
 ;
 ;This routine locates a a unique three digit site id used by Community Care and updates the newly added
 ;  GMRC UNIQUE CONSULT SITE ID paramater with the value for this site.
 ; if a value is not identified, a default value of 999 is used
 Q
 ;
POST ;updates GMRC UNIQUE CONSULT ID paramater with a mapped value
 N GMRCSITE,GMRCID
 N GMRCHECK ;pij 4/8/2018
 ;
 ;*** v8 I am adding a default of 999 to the PARAMETERS file. PIJ 5/3/2018
 D EN^XPAR("PKG.CONSULT/REQUEST TRACKING","GMRC UNIQUE CONSULT SITE ID",,999)
 ;***
 ;
 S GMRCSITE=$P($$SITE^VASITE(),U,3)
 S GMRCID=$$GET^XPAR("PKG.CONSULT/REQUEST TRACKING","GMRC UNIQUE CONSULT SITE ID") ;If this value has been set, don't overwrite
 ;I $G(GMRCID)'="" D
 I $G(GMRCID)'=999 D  ; We are shipping 999 as a value from #8989.5
 .D MES^XPDUTL("Your GMRC UNIQUE CONSULT SITE ID value was found in the PARAMETER file: "_GMRCID)
 .I (GMRCID=999) D
 ..S GMRCID=""
 ..D MES^XPDUTL("Will look for a mapped value to replace default 999")
 ;I $G(GMRCID)="" D
 I $G(GMRCID)=999 D
 .S GMRCID=$$MAPID(GMRCSITE)
 .D BMES^XPDUTL()
 .D MES^XPDUTL("*********************************")
 .D MES^XPDUTL("PLEASE NOTE: Your SITE ID will not be changed.")
 .D MES^XPDUTL("The GMRC UNIQUE CONSULT SITE ID parameter will be set.")
 .D MES^XPDUTL("*********************************")
 .D BMES^XPDUTL()
 .D MES^XPDUTL("These are the instructions for the patch installer at your site...")
 .D MES^XPDUTL("1. Your SITE ID number is... '"_GMRCSITE_"'")
 .D MES^XPDUTL("2. Your GMRC UNIQUE CONSULT SITE ID number is... '"_GMRCID_"'")
 .D MES^XPDUTL("3. Please reference the attached Post-Install instructions to verify that the GMRC UNIQUE CONSULT SITE ID is correct")
 .D EN^XPAR("PKG.CONSULT/REQUEST TRACKING","GMRC UNIQUE CONSULT SITE ID",,GMRCID)
 .;
 .D BMES^XPDUTL()
 .D MES^XPDUTL("Your GMRC UNIQUE CONSULT SITE ID value has been set in the PARAMETER file: "_$$GET^XPAR("PKG.CONSULT/REQUEST TRACKING","GMRC UNIQUE CONSULT SITE ID"))
 D BMES^XPDUTL()
 D MES^XPDUTL("If your GMRC UNIQUE CONSULT SITE ID number is '999' please contact IRM for assistance")
 Q
 ;
MAPID(GMRCSITE)  ;RETURN A MAPPED 3 DIGIT VALUE FOR A SITE ID - DEFAULT TO 999
 ; INPUT GMRCSITE IS THE SITE ID
 ; RETURN: IS THE MAPPED GMRC VISTA SITE ID
 N GMRCRTN
 N GMRCNXT ;pij 4/8/2018
 S GMRCRTN=999
 S GMRCNXT=1
 F  S GMRCNXT=$T(MAP)+GMRCNXT Q:GMRCNXT=0  D
 .S GMRCHECK=$P($T(MAP+GMRCNXT),";;",2)
 .I $P(GMRCHECK,":",1)=GMRCSITE S GMRCRTN=$P(GMRCHECK,":",2)
 .S:GMRCRTN=999 GMRCNXT=GMRCNXT+1
 .S:GMRCRTN'=999 GMRCNXT=0
 .S:GMRCHECK="" GMRCNXT=0
 Q GMRCRTN
MAP ;;ASSOCIATE SITE ID TO THREE DIGIT CC SITE ID
 ;;402:202
 ;;405:203
 ;;518:204
 ;;523:205
 ;;608:208
 ;;631:209
 ;;650:210
 ;;689:212
 ;;526:218
 ;;528:215
 ;;528A5:216
 ;;528A6:214
 ;;528A7:217
 ;;528A8:213
 ;;561:221
 ;;620:223
 ;;630:224
 ;;632:225
 ;;460:226
 ;;503:227
 ;;529:228
 ;;542:230
 ;;562:231
 ;;595:232
 ;;642:233
 ;;646:234
 ;;693:235
 ;;512:236
 ;;517:241
 ;;540:229
 ;;581:265
 ;;613:239
 ;;688:240
 ;;558:242
 ;;565:243
 ;;590:244
 ;;637:245
 ;;652:246
 ;;658:247
 ;;659:248
 ;;508:249
 ;;509:250
 ;;521:251
 ;;534:252
 ;;544:253
 ;;557:254
 ;;619:256
 ;;679:257
 ;;516:258
 ;;546:259
 ;;548:260
 ;;573:261
 ;;672:263
 ;;673:264
 ;;675:358
 ;;596:267
 ;;603:268
 ;;614:269
 ;;621:270
 ;;626:272
 ;;506:279
 ;;515:280
 ;;538:273
 ;;539:274
 ;;541:276
 ;;552:277
 ;;553:282
 ;;583:283
 ;;610:284
 ;;655:285
 ;;757:278
 ;;537:287
 ;;550:281
 ;;556:288
 ;;578:289
 ;;585:290
 ;;607:291
 ;;676:292
 ;;695:293
 ;;589:295
 ;;589A4:294
 ;;589A5:297
 ;;589A7:298
 ;;657:302
 ;;657A4:300
 ;;657A5:299
 ;;502:303
 ;;520:304
 ;;564:305
 ;;580:306
 ;;586:307
 ;;598:308
 ;;629:310
 ;;667:312
 ;;504:317
 ;;519:318
 ;;549:313
 ;;671:314
 ;;674:315
 ;;740:427
 ;;756:322
 ;;436:323
 ;;442:325
 ;;554:326
 ;;575:327
 ;;623:309
 ;;635:311
 ;;660:328
 ;;666:329
 ;;463:330
 ;;531:331
 ;;648:332
 ;;653:333
 ;;663:334
 ;;668:335
 ;;687:336
 ;;692:337
 ;;459:339
 ;;570:340
 ;;593:345
 ;;612A4:341
 ;;640:342
 ;;654:343
 ;;662:344
 ;;501:316
 ;;600:346
 ;;605:347
 ;;644:319
 ;;649:320
 ;;664:348
 ;;678:321
 ;;691:349
 ;;437:350
 ;;438:351
 ;;568:352
 ;;618:353
 ;;636:356
 ;;636A6:354
 ;;636A8:355
 ;;656:357
 Q
