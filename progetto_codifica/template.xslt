<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns="http://www.w3.org/1999/xhtml">
  <xsl:output method="html" encoding="UTF-8" indent="yes" omit-xml-declaration="no" />
  <xsl:strip-space elements="*" />
  <xsl:preserve-space elements="tei:s tei:cl"  />
<!-- VARIABILI GLOBALI  -->
  <!-- Testo -->
  <xsl:variable name="txt_ll" select="/tei:TEI/tei:text"/>
  <xsl:variable name="url_g" select="/tei:TEI/tei:teiHeader/tei:encodingDesc/tei:charDecl/tei:glyph/tei:figure/tei:graphic"/>
  <!-- Mappatura -->
  <xsl:variable name="url" select="/tei:TEI/tei:facsimile/tei:surface/tei:graphic/@url"/>
  <xsl:variable name="id_map" select="/tei:TEI/tei:facsimile/tei:surface/tei:graphic/@xml:id" />
  <!-- Risorse varie-->
  <xsl:variable name="title" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
  <xsl:variable name="rsp" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt"/>
  <xsl:variable name="pub" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt"/>
  <xsl:variable name="profile" select="/tei:TEI/tei:teiHeader/tei:profileDesc"/>
  <xsl:variable name="source" select="/tei:TEI/tei:teiHeader/tei:fileDesc/tei:sourceDesc"/>

<!-- TEMPLATES -->
  <!-- Gestione head -->
  <xsl:template name="head">
    <link rel="stylesheet" href="./site/style.css" type="text/css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"/>
    <script src="./site/main.js" type="text/javascript"/>
    <title><xsl:value-of select="$title"/></title>
  </xsl:template>
  <!-- Gestione header -->
  <xsl:template name="header">
    <img src="{$pub/tei:publisher/tei:figure/tei:graphic/@url}" alt="Università di Pisa" id="{$pub/tei:publisher/tei:figure/tei:graphic/@xml:id}" />
    <h1>Esame di Codifica di Testi a.a. 2019/2020</h1>
    <h2>Università di Pisa</h2>
  </xsl:template>
  <!-- Gestione Intestazione -->
  <xsl:template name="intest">
    <xsl:variable name="corr" select="$profile/tei:correspDesc/tei:correspAction"/>
    <xsl:for-each select="$corr[@type='sent']">
      <p>
        <xsl:value-of select="tei:placeName" />
        <xsl:text>, </xsl:text>
        <xsl:value-of select="tei:date" />
      </p>
    </xsl:for-each>
    <p><xsl:value-of select="$title"/></p>
    <xsl:for-each select="$source/tei:msDesc">
      <p>
        <xsl:value-of select="tei:msIdentifier/tei:repository" />
        <xsl:text>. </xsl:text>
        <xsl:value-of select="tei:msContents/tei:summary" />
      </p>
    </xsl:for-each>
    <xsl:variable name="l_B" select="$source/tei:listBibl"/>
    <xsl:for-each select="$l_B">
      <p>
        <xsl:value-of select="tei:head"/>
        <xsl:text>: </xsl:text>
        <xsl:for-each select="$l_B/tei:bibl">
          <xsl:value-of select="tei:publisher/tei:choice/tei:abbr"/>
          <xsl:text> </xsl:text>
          <xsl:value-of select="tei:biblScope"/>
          <xsl:text> </xsl:text>
        </xsl:for-each>
      </p>
    </xsl:for-each>
    <p>
      <xsl:text>Ubicazione maggio 2018: </xsl:text>
      <xsl:variable name="spDesc" select="$source/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc"/>
      <xsl:for-each select="$spDesc/tei:support">
        <xsl:value-of select="tei:p" />
      </xsl:for-each>
      <xsl:for-each select="$spDesc/tei:support/tei:dimensions">
        <xsl:value-of select="tei:height" />
        <xsl:text> x </xsl:text>
        <xsl:value-of select="tei:width" />
      </xsl:for-each>
    </p>
    <p>
      <xsl:text>Stato fisico: </xsl:text>
      <xsl:value-of select="$source/tei:msDesc/tei:physDesc/tei:objectDesc/tei:supportDesc/tei:condition"/>
    </p>
    <p>
      <xsl:text>Lingua: </xsl:text>
      <xsl:value-of select="$source/tei:msDesc/tei:msContents/tei:msItem/tei:textLang"/>
    </p>
  </xsl:template>
  <!-- Gestione testo lettera -->
  <xsl:template name="txt_letter">
    <xsl:for-each select="$txt_ll/tei:body/tei:div/tei:gap">
      <p></p>
    </xsl:for-each>
    <p><xsl:value-of select="$txt_ll/tei:body/tei:div/tei:opener/tei:salute/tei:s/tei:gap"/></p>
    <p><xsl:value-of select="$txt_ll/tei:body/tei:div/tei:opener/tei:salute/tei:s/tei:g"/></p>
    <xsl:for-each select="$txt_ll/tei:body/tei:div/tei:opener">
      <p>
        <xsl:value-of select="tei:salute"/>
      </p>
    </xsl:for-each>
    <xsl:for-each select="$txt_ll/tei:body/tei:div/tei:ab/tei:s">
      <xsl:for-each select="tei:cl">
        <p>
          <xsl:value-of select="."/>
        </p>
      </xsl:for-each>
    </xsl:for-each>
  </xsl:template>
  <!-- Mappatura -->
  <xsl:template name="ovrl_img">
    <img src="{$url}" alt="lettera" height="800px" width="auto" id="{$id_map}" />
  </xsl:template>
  <!-- Note -->
  <xsl:template name="txt_notes">
    <xsl:variable name="note" select="$txt_ll/tei:back/tei:div/tei:note"/>
    <p>
      <b><i><xsl:text>[1] nota Seminara2017 n.677, p. 400 - </xsl:text></i></b>
      <xsl:value-of select="$note[1]"/>
    </p>
    <p>
      <b><i><xsl:text>[2] (nota Seminara2017 n.698, p. 527) - </xsl:text></i></b>
      <xsl:value-of select="$note[2]"/>
    </p>
    <p>
      <b><i><xsl:text>[3] - </xsl:text></i></b>
      <xsl:value-of select="$note[3]"/>
    </p>
  </xsl:template>
  <!-- Responsabili -->
  <xsl:template name="resp">
   <p>
      <b>
        <xsl:value-of select="$rsp[1]/tei:resp"/>
        <xsl:value-of select="$rsp[1]/tei:persName[1]"/>
        <xsl:text>, mat. 584174 &amp; </xsl:text>
        <xsl:value-of select="$rsp[1]/tei:persName[2]"/>
        <xsl:text>, mat. 566830. </xsl:text>
      </b>
    </p>
    <p>
      <b>
        <xsl:value-of select="$rsp[2]/tei:resp"/>
        <xsl:value-of select="$rsp[2]/tei:persName"/>
      </b>
    </p>
  </xsl:template>
  <!-- Distribuzione -->
  <xsl:template name="dist">
    <p>
      <b>
        <xsl:text>Pubblicazione e Distribuzione del documento a cura di:</xsl:text> <br/>
        <xsl:value-of select="$pub/tei:publisher"/>
        <xsl:text> - </xsl:text>
        <xsl:value-of select="$pub/tei:availability"/>
        <xsl:text> - </xsl:text>
        <xsl:value-of select="$pub/tei:date"/><br/>
        <xsl:value-of select="$pub/tei:distributor/tei:address/tei:addrLine"/>
      </b>
    </p>
  </xsl:template>

  <!-- MAIN STRUCTURE -->
  <xsl:template match="/tei:TEI">
    <html>
      <head>
        <xsl:call-template name="head" />
      </head>
      <body>
        <header>
          <xsl:call-template name="header" />
        </header>
        <nav>
          <div class="closebtn"></div>
        </nav>
        <section class="content">
          <!-- Main Page -->
          <div id="container">
            <table>
              <tbody>
                <tr>
                  <th colspan="2">Lettera</th>
                </tr>
                <tr>
                  <td id="ico_letter">
                    <img src="./site/imgFile/tabimg.png" alt="Preview Lettera"  width="270" height="auto" id="img_preview" />
                  </td>
                  <td class="desc">
                    <div id="intest">
                      <xsl:call-template name="intest" />
                    </div>
                    <div id="{$txt_ll/@type}">
                      <xsl:call-template name="txt_letter" />
                    </div>
                    <button type="button" class="btn"><p>Here</p></button>
                    <button type="button" class="btn2"><p>Again</p></button>
                  </td>	
                </tr>
              </tbody>
            </table>
          </div>
          <!-- Overlay -->
          <div id="big">
            <table>
              <tbody>
                <tr>
                  <td id="full_img">
                    <xsl:call-template name="ovrl_img" />
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </section>
        <section class="notes">
          <xsl:call-template name="txt_notes" />
        </section>
        <footer>
          <table>
            <tbody>
            <tr>
            <td>
              <xsl:call-template name="resp" />
            </td>
            <td>
              <xsl:call-template name="dist" />
            </td>
            </tr>
            </tbody>
            </table>
        </footer>
      </body>
    </html>
  </xsl:template>
</xsl:stylesheet>
