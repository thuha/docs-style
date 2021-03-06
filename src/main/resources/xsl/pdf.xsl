<?xml version='1.0'?>

<!--
   Copyright 2007 Red Hat, Inc.
   License: GPL
   Author: Jeff Fearn <jfearn@redhat.com>
   Author: Tammy Fox <tfox@redhat.com>
   Author: Andy Fitzsimon <afitzsim@redhat.com>
   Author: Mark Newton <mark.newton@jboss.org>
   Author: Pete Muir
-->

<!DOCTYPE xsl:stylesheet [
<!ENTITY lowercase "'abcdefghijklmnopqrstuvwxyz'">
<!ENTITY uppercase "'ABCDEFGHIJKLMNOPQRSTUVWXYZ'">
 ]>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0"
   xmlns="http://www.w3.org/TR/xhtml1/transitional"
   xmlns:fo="http://www.w3.org/1999/XSL/Format"
   xmlns:jbh="java:org.jboss.highlight.renderer.FORenderer"
   exclude-result-prefixes="jbh">

   <xsl:import href="http://docbook.sourceforge.net/release/xsl/1.76.1/fo/docbook.xsl" />

   <xsl:import href="common.xsl" />

   <xsl:param name="confidential">0</xsl:param>
   <xsl:param name="alignment">justify</xsl:param>
   <xsl:param name="fop.extensions" select="1" />
   <xsl:param name="fop1.extensions" select="0" />
   <xsl:param name="img.src.path" />
   <xsl:param name="qandadiv.autolabel" select="0" />

   <xsl:param name="hyphenation-character">-</xsl:param>
   <!--xsl:param name="hyphenate.verbatim" select="0"/-->
   <xsl:param name="hyphenate">true</xsl:param>
   <!--xsl:param name="ulink.hyphenate" select="1"/-->

<!-- Define spacing around paragraphs-->
	<xsl:attribute-set name="normal.para.spacing">
	<xsl:attribute name="space-before.minimum">2mm</xsl:attribute>
	<xsl:attribute name="space-before.optimum">2mm</xsl:attribute>
	<xsl:attribute name="space-before.maximum">2mm</xsl:attribute>
	</xsl:attribute-set>

   <xsl:param name="line-height" select="1.5" />

   <!-- Admonitions -->
   <xsl:param name="admon.graphics" select="1"/>
   <xsl:param name="admon.graphics.extension" select="'.png'"/>
   <xsl:template match="*" mode="admon.graphic.width">
  <xsl:param name="node" select="."/>
  <xsl:text>24pt</xsl:text>
   </xsl:template>

   <xsl:attribute-set name="admonition.title.properties">
      <xsl:attribute name="font-size">10pt</xsl:attribute>
      <xsl:attribute name="color">
  <xsl:choose>
    <xsl:when test="self::note">#4C5253</xsl:when>
    <xsl:when test="self::caution">#4C5253</xsl:when>
    <xsl:when test="self::important">#4C5253</xsl:when>
    <xsl:when test="self::warning">#4C5253</xsl:when>
    <xsl:when test="self::tip">#4C5253</xsl:when>
    <xsl:otherwise>white</xsl:otherwise>
  </xsl:choose>
        </xsl:attribute>

      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
      <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>

   </xsl:attribute-set>

   <xsl:attribute-set name="graphical.admonition.properties">

      <xsl:attribute name="color">
  <xsl:choose>
    <xsl:when test="self::note">#4C5253</xsl:when>
    <xsl:when test="self::caution">#4C5253</xsl:when>
    <xsl:when test="self::important">#4C5253</xsl:when>
    <xsl:when test="self::warning">#4C5253</xsl:when>
    <xsl:when test="self::tip">#4C5253</xsl:when>
    <xsl:otherwise>white</xsl:otherwise>
  </xsl:choose>
        </xsl:attribute>
      <xsl:attribute name="background-color">
      <xsl:choose>
    <xsl:when test="self::note">#E8E8C1</xsl:when>
    <xsl:when test="self::caution">#E3A835</xsl:when>
    <xsl:when test="self::important">#4A5D75</xsl:when>
    <xsl:when test="self::warning">#FFE000</xsl:when>
    <xsl:when test="self::tip">#D5D5E8</xsl:when>
    <xsl:otherwise>#404040</xsl:otherwise>
      </xsl:choose>
        </xsl:attribute>

      <xsl:attribute name="space-before.optimum">1em</xsl:attribute>
      <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
      <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
      <xsl:attribute name="space-after.optimum">1em</xsl:attribute>
      <xsl:attribute name="space-after.minimum">0.8em</xsl:attribute>
      <xsl:attribute name="space-after.maximum">1em</xsl:attribute>
      <xsl:attribute name="padding-bottom">12pt</xsl:attribute>
      <xsl:attribute name="padding-top">12pt</xsl:attribute>
      <xsl:attribute name="padding-right">12pt</xsl:attribute>
      <xsl:attribute name="padding-left">12pt</xsl:attribute>
      <xsl:attribute name="padding">20pt</xsl:attribute>
      <xsl:attribute name="margin">0pt</xsl:attribute>
      <xsl:attribute name="margin-left">
    <xsl:value-of select="$title.margin.left" />
  </xsl:attribute>
   </xsl:attribute-set>

   <!-- Font style for programlisting -->
   <xsl:param name="programlisting.font" select="'verdana,helvetica,sans-serif'" />

   <!-- Make the font for programlisting slightly smaller -->
   <xsl:param name="programlisting.font.size" select="'80%'" />
 <xsl:param name="body.font.size" select="'75%'" />
  <xsl:param name="chapter.title.font.size" select="'60%'" /> 
 <xsl:param name="section.title.font.size" select="'60%'" /> 
  <xsl:param name="title.font.size" select="'60%'" /> 

   <!-- Make the section depth in the TOC 2, same as html -->
   <xsl:param name="toc.section.depth">2</xsl:param>

   <!-- Now, set enable scalefit for large images -->
   <xsl:param name="graphicsize.extension" select="'1'" />
   <xsl:param name="default.image.width">17.4cm</xsl:param>

   <xsl:attribute-set name="xref.properties">
      <xsl:attribute name="font-style">normal</xsl:attribute>
      <xsl:attribute name="color">
	<xsl:choose>
		<xsl:when
               test="ancestor::note or ancestor::caution or ancestor::important or ancestor::warning or ancestor::tip">
			<xsl:text>#0C46BC</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>#0066cc</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="monospace.properties">
      <xsl:attribute name="font-size">9pt</xsl:attribute>
      <xsl:attribute name="font-family">
		<xsl:value-of select="$monospace.font.family" />
	</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="monospace.verbatim.properties"
      use-attribute-sets="verbatim.properties monospace.properties">
      <xsl:attribute name="text-align">start</xsl:attribute>
      <xsl:attribute name="wrap-option">wrap</xsl:attribute>
      <xsl:attribute name="hyphenation-character">&#x25BA;</xsl:attribute>
   </xsl:attribute-set>

   <xsl:param name="shade.verbatim" select="1" />
   <xsl:attribute-set name="shade.verbatim.style">
      <xsl:attribute name="wrap-option">wrap</xsl:attribute>
      <xsl:attribute name="background-color">
	<xsl:choose>
		<xsl:when test="ancestor::note"> <xsl:text>#B5BCBD</xsl:text> </xsl:when>
		<xsl:when test="ancestor::caution"> <xsl:text>#E3A835</xsl:text> </xsl:when>
		<xsl:when test="ancestor::important"> <xsl:text>#4A5D75</xsl:text> </xsl:when>
		<xsl:when test="ancestor::warning"> <xsl:text>#7B1E1E</xsl:text> </xsl:when>
		<xsl:when test="ancestor::tip"> <xsl:text>#7E917F</xsl:text> </xsl:when>
		<xsl:otherwise>
			<xsl:text>black</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:attribute>
      <xsl:attribute name="color">
	<xsl:choose>
		<xsl:when test="ancestor::note"> <xsl:text>#4C5253</xsl:text> </xsl:when>
		<xsl:when test="ancestor::caution"> <xsl:text>#533500</xsl:text> </xsl:when>
		<xsl:when test="ancestor::important"> <xsl:text>white</xsl:text> </xsl:when>
		<xsl:when test="ancestor::warning"> <xsl:text>white</xsl:text> </xsl:when>
		<xsl:when test="ancestor::tip"> <xsl:text>white</xsl:text> </xsl:when>
		<xsl:otherwise>
			<xsl:text>red</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
  </xsl:attribute>
      <xsl:attribute name="padding-left">12pt</xsl:attribute>
      <xsl:attribute name="padding-right">12pt</xsl:attribute>
      <xsl:attribute name="padding-top">6pt</xsl:attribute>
      <xsl:attribute name="padding-bottom">6pt</xsl:attribute>
      <xsl:attribute name="margin-left">
		<xsl:value-of select="$title.margin.left" />
	</xsl:attribute>
   </xsl:attribute-set>

<!-- Set properties for Example block --> 
	<!-- properties for the example title -->
	<xsl:attribute-set name="formal.title.properties">
      <xsl:attribute name="font-size">10pt</xsl:attribute> 
      <xsl:attribute name="color">#393939</xsl:attribute>	  	  
	</xsl:attribute-set> 
	<!-- properties for the example content -->
	<xsl:attribute-set name="example.properties">
      <xsl:attribute name="font-size">10pt</xsl:attribute> 
      <xsl:attribute name="color">#393939</xsl:attribute>	  
	  <xsl:attribute name="border-left">1pt solid #CCCCCC</xsl:attribute>
	  <xsl:attribute name="padding-left">2pt</xsl:attribute>    	
	</xsl:attribute-set> 
   
<!-- Set the vertical spacing around the various verbatim-type elements (programlisting, literallayout) -->
<xsl:attribute-set name="verbatim.properties">
	<xsl:attribute name="line-height">0.5</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.4em</xsl:attribute>
	<xsl:attribute name="space-before.optimum">>0.5em</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.6em</xsl:attribute>
	<xsl:attribute name="space-after.minimum">0.4em</xsl:attribute>
	<xsl:attribute name="space-after.optimum">0.5em</xsl:attribute>
	<xsl:attribute name="space-after.maximum">0.6em</xsl:attribute>
	<xsl:attribute name="hyphenate">false</xsl:attribute>
	<xsl:attribute name="wrap-option">wrap</xsl:attribute>
	<xsl:attribute name="white-space-collapse">false</xsl:attribute>
	<xsl:attribute name="white-space-treatment">preserve</xsl:attribute>
	<xsl:attribute name="linefeed-treatment">preserve</xsl:attribute>
	<xsl:attribute name="text-align">start</xsl:attribute>
</xsl:attribute-set>
    
   <!--Show the text: Table of Contents at the beginning of Toc page-->
   <xsl:param name="generate.toc">set toc book toc,title article toc</xsl:param>

   <!--###################################################
      Custom TOC (bold chapter titles)
      ################################################### -->

<!-- Improve the TOC -->
    <!--Change Contents into Table of Contents -->	
	<xsl:param name="local.l10n.xml" select="document('')"/> 
	<l:i18n xmlns:l="http://docbook.sourceforge.net/xmlns/l10n/1.0"> 
		<l:l10n language="en"> 
		<l:context name="title">
           <l:template name="example" text="Example: %t "/><!-- Change "Example number title" to "Example: title"-->
       </l:context>   	
		<l:gentext key="TableofContents" text="Table of Contents"/>
		</l:l10n>
	</l:i18n>
   <xsl:template name="toc.line">
      <xsl:variable name="id">
         <xsl:call-template name="object.id" />
      </xsl:variable>

      <xsl:variable name="label">
         <xsl:apply-templates select="." mode="label.markup" />
      </xsl:variable>

      <fo:block text-align-last="justify" end-indent="{$toc.indent.width}pt"
         last-line-end-indent="-{$toc.indent.width}pt">
         <fo:inline keep-with-next.within-line="always">
            <fo:basic-link internal-destination="{$id}">

               <!-- Chapter titles should be bold. -->
               <xsl:choose>
                  <xsl:when test="local-name(.) = 'chapter'">
                     <xsl:attribute name="font-weight">bold</xsl:attribute>
                  </xsl:when>
               </xsl:choose>

               <xsl:if test="$label != ''">
                  <xsl:copy-of select="$label" />
                  <xsl:value-of select="$autotoc.label.separator" />
               </xsl:if>
               <xsl:apply-templates select="." mode="titleabbrev.markup" />
            </fo:basic-link>
         </fo:inline>
         <fo:inline keep-together.within-line="always">
            <xsl:text> </xsl:text>
            <fo:leader leader-pattern="dots" leader-pattern-width="3pt"
               leader-alignment="reference-area" keep-with-next.within-line="always" />
            <xsl:text> </xsl:text>
            <fo:basic-link internal-destination="{$id}">
               <fo:page-number-citation ref-id="{$id}" />
            </fo:basic-link>
         </fo:inline>
      </fo:block>
   </xsl:template>

   <!-- Format Variable Lists as Blocks (prevents horizontal overflow). -->
   <xsl:param name="variablelist.as.blocks">1</xsl:param>

<!--Define style for list-item -->
<xsl:attribute-set name="list.block.spacing">
	<xsl:attribute name="margin-left">
		<xsl:choose>
			<xsl:when test="self::itemizedlist">1em</xsl:when>
			<xsl:otherwise>0pt</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>
	<xsl:attribute name="space-before.optimum">0.75em</xsl:attribute>
	<xsl:attribute name="space-before.minimum">0.70em</xsl:attribute>
	<xsl:attribute name="space-before.maximum">0.80em</xsl:attribute>
	<xsl:attribute name="space-after.optimum">0.75em</xsl:attribute>
	<xsl:attribute name="space-after.minimum">0.70em</xsl:attribute>
	<xsl:attribute name="space-after.maximum">0.80em</xsl:attribute>
</xsl:attribute-set>

   <!-- Set spacing around individual items in the list -->
	<xsl:attribute-set name="list.item.spacing">
		<xsl:attribute name="space-before.optimum">0.40em</xsl:attribute>
		<xsl:attribute name="space-before.minimum">0.40em</xsl:attribute>
		<xsl:attribute name="space-before.maximum">0.40em</xsl:attribute>
	</xsl:attribute-set>

   <!-- Some padding inside tables -->
   <xsl:attribute-set name="table.cell.padding">
      <xsl:attribute name="padding-left">4pt</xsl:attribute>
      <xsl:attribute name="padding-right">4pt</xsl:attribute>
      <xsl:attribute name="padding-top">2pt</xsl:attribute>
      <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
   </xsl:attribute-set>
   
   <!-- TABLE FORMAT / fix: wikbook version 0.9.41 causes missing table borders /--> 

   <xsl:template name="table.cell.properties"> 
		<xsl:if test="ancestor::thead or ancestor::tfoot">	
		  <xsl:attribute name="background-color">#f0f0f0</xsl:attribute>	
		  <xsl:attribute name="text-align">center</xsl:attribute>	
		</xsl:if>
        <xsl:attribute name="border-start-style">solid</xsl:attribute>
        <xsl:attribute name="border-end-style">solid</xsl:attribute>
        <xsl:attribute name="border-top-style">solid</xsl:attribute>
		<xsl:attribute name="border-bottom-style">solid</xsl:attribute>
		<xsl:attribute name="border-start-width">0.1pt</xsl:attribute>
		<xsl:attribute name="border-end-width">0.1pt</xsl:attribute>
		<xsl:attribute name="border-top-width">0.1pt</xsl:attribute>
		<xsl:attribute name="border-bottom-width">0.1pt</xsl:attribute>
		<xsl:attribute name="border-start-color">#cfcfcf</xsl:attribute>
		<xsl:attribute name="border-end-color">#cfcfcf</xsl:attribute>
		<xsl:attribute name="border-bottom-color">#cfcfcf</xsl:attribute>
		<xsl:attribute name="border-top-color">#cfcfcf</xsl:attribute>					
   </xsl:template>	

	<xsl:template match="entry//text()">
		<xsl:call-template name="hyphenate-url">
			<xsl:with-param name="url" select="."/>
		</xsl:call-template>
	</xsl:template>
	
   <!-- Only hairlines as frame and cell borders in tables -->
   <xsl:param name="table.frame.border.thickness">0.1pt</xsl:param>
   <xsl:param name="table.cell.border.thickness">0.1pt</xsl:param>
   <xsl:param name="table.cell.border.color">#cfcfcf</xsl:param>
   <xsl:param name="table.frame.border.color">#cfcfcf</xsl:param>
   <xsl:param name="table.cell.border.right.color">#cfcfcf</xsl:param>
   <xsl:param name="table.cell.border.left.color">#cfcfcf</xsl:param>
   <xsl:param name="table.frame.border.right.color">#cfcfcf</xsl:param>
   <xsl:param name="table.frame.border.left.color">#cfcfcf</xsl:param>
   <!-- Paper type, no headers on blank pages, no double sided printing -->
   <xsl:param name="paper.type" select="'A4'" />
   <xsl:param name="double.sided">1</xsl:param>
   <xsl:param name="headers.on.blank.pages">1</xsl:param>
   <xsl:param name="footers.on.blank.pages">1</xsl:param>
   <!--xsl:param name="header.column.widths" select="'1 4 1'"/-->
   <xsl:param name="header.column.widths" select="'1 0 1'" />
   <xsl:param name="footer.column.widths" select="'1 1 1'" />
   <xsl:param name="header.rule" select="1" />

   <!-- Space between paper border and content (chaotic stuff, don't touch) -->

   <xsl:param name="page.margin.top">10mm</xsl:param>
   <xsl:param name="region.before.extent">10mm</xsl:param>
   <xsl:param name="body.margin.top">12mm</xsl:param>

   <xsl:param name="body.margin.bottom">15mm</xsl:param>
   <xsl:param name="region.after.extent">10mm</xsl:param>
   <xsl:param name="page.margin.bottom">9mm</xsl:param>

   <xsl:param name="page.margin.outer">19.5mm</xsl:param>
   <xsl:param name="page.margin.inner">19.5mm</xsl:param>

   <!-- No intendation of Titles -->
   <xsl:param name="body.start.indent">0pt</xsl:param>

   <xsl:param name="title.color">#285A92</xsl:param>
   <xsl:param name="chapter.title.color" select="$title.color" />
   <xsl:param name="section.title.color" select="$title.color" />
   <!-- Define properties for section title1 -->
   <xsl:attribute-set name="section.title.level1.properties">
      <xsl:attribute name="color"><xsl:value-of select="$section.title.color" />
      </xsl:attribute>
      <xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.6" />
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
    <xsl:attribute name="border-bottom">0.5pt dashed #285A92</xsl:attribute>
    <xsl:attribute name="padding-top">6pt</xsl:attribute>
    <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="section.title.level2.properties">
      <xsl:attribute name="color"><xsl:value-of select="$section.title.color" />
      </xsl:attribute>
      <xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.4" />
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="section.title.level3.properties">
      <xsl:attribute name="color"><xsl:value-of select="$section.title.color" />
      </xsl:attribute>
      <xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.3" />
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="section.title.level4.properties">
      <xsl:attribute name="color"><xsl:value-of select="$section.title.color" />
      </xsl:attribute>
      <xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.2" />
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="section.title.level5.properties">
      <xsl:attribute name="color"><xsl:value-of select="$section.title.color" />
      </xsl:attribute>
      <xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master * 1.1" />
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="section.title.level6.properties">
      <xsl:attribute name="color"><xsl:value-of select="$section.title.color" />
      </xsl:attribute>
      <xsl:attribute name="font-size">
		<xsl:value-of select="$body.font.master" />
		<xsl:text>pt</xsl:text>
	</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="section.title.properties">
      <xsl:attribute name="font-family">
		<xsl:value-of select="$title.font.family" />
	</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <!-- font size is calculated dynamically by section.heading template -->
      <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
      <xsl:attribute name="space-before.minimum">0.8em</xsl:attribute>
      <xsl:attribute name="space-before.optimum">1.0em</xsl:attribute>
      <xsl:attribute name="space-before.maximum">1.2em</xsl:attribute>
      <xsl:attribute name="text-align">left</xsl:attribute>
      <xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left" />
      </xsl:attribute>
   </xsl:attribute-set>

   <xsl:param name="titlepage.color" select="$title.color" />

   <xsl:attribute-set name="book.titlepage.recto.style">
      <xsl:attribute name="font-family">
		<xsl:value-of select="$title.fontset" />
	</xsl:attribute>
      <xsl:attribute name="color"><xsl:value-of select="$titlepage.color" />
      </xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="font-size">12pt</xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="component.title.properties">
      <xsl:attribute name="keep-with-next.within-column">always</xsl:attribute>
      <xsl:attribute name="space-before.optimum"><xsl:value-of
            select="concat($body.font.master, 'pt')" />
      </xsl:attribute>
      <xsl:attribute name="space-before.minimum"><xsl:value-of
            select="concat($body.font.master, 'pt')" />
      </xsl:attribute>
      <xsl:attribute name="space-before.maximum"><xsl:value-of
            select="concat($body.font.master, 'pt')" />
      </xsl:attribute>
      <xsl:attribute name="hyphenate">false</xsl:attribute>
      <xsl:attribute name="color">
		<xsl:choose>
			<xsl:when test="not(parent::chapter | parent::article | parent::appendix)"><xsl:value-of
                  select="$title.color" />
			</xsl:when>
		</xsl:choose>
	</xsl:attribute>
      <xsl:attribute name="text-align">
		<xsl:choose>
			<xsl:when
               test="((parent::article | parent::articleinfo) and not(ancestor::book) and not(self::bibliography))				 or (parent::slides | parent::slidesinfo)">center</xsl:when>
			<xsl:otherwise>left</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>
      <xsl:attribute name="start-indent"><xsl:value-of select="$title.margin.left" />
      </xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="chapter.titlepage.recto.style">
      <xsl:attribute name="color"><xsl:value-of select="$chapter.title.color" />
      </xsl:attribute>
      <xsl:attribute name="background-color">white</xsl:attribute>
      <xsl:attribute name="font-size">
		<xsl:choose>
			<xsl:when test="$l10n.gentext.language = 'ja-JP'">
				<xsl:value-of select="$body.font.master * 1.7" />
				<xsl:text>pt</xsl:text>
			</xsl:when>
			<xsl:otherwise>
				<xsl:text>24pt</xsl:text>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
      <xsl:attribute name="text-align">left</xsl:attribute>
      <!--xsl:attribute name="wrap-option">no-wrap</xsl:attribute-->
      <xsl:attribute name="padding-left">1em</xsl:attribute>
      <xsl:attribute name="padding-right">1em</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="preface.titlepage.recto.style">
      <xsl:attribute name="font-family">
		<xsl:value-of select="$title.fontset" />
	</xsl:attribute>
      <xsl:attribute name="color">#285A92</xsl:attribute>
      <xsl:attribute name="font-size">12pt</xsl:attribute>
      <xsl:attribute name="font-weight">bold</xsl:attribute>
   </xsl:attribute-set>

   <xsl:attribute-set name="part.titlepage.recto.style">
      <xsl:attribute name="color"><xsl:value-of select="$title.color" />
      </xsl:attribute>
      <xsl:attribute name="text-align">center</xsl:attribute>
   </xsl:attribute-set>


   <!--
      From: fo/table.xsl
      Reason: Table Header format
      Version:1.72
   -->
   <xsl:template name="table.cell.block.properties">
      <!-- highlight this entry? -->
      <xsl:if test="ancestor::thead or ancestor::tfoot">
         <xsl:attribute name="font-weight">bold</xsl:attribute>
         <xsl:attribute name="background-color">#F0F0F0</xsl:attribute>
         <xsl:attribute name="color">#393939</xsl:attribute>
		 <xsl:attribute name="padding-top">2pt</xsl:attribute>
		 <xsl:attribute name="padding-bottom">2pt</xsl:attribute>
		 <xsl:attribute name="padding-left">4pt</xsl:attribute>
		 <xsl:attribute name="padding-right">4pt</xsl:attribute>	
      </xsl:if>
   </xsl:template>
   <!-- Hide URL -->
   <xsl:param name="ulink.show" select="0"/>
   <!--
      From: fo/table.xsl
      Reason: Table Header format
      Version:1.72
   -->
   <!-- customize this template to add row properties -->
   <xsl:template name="table.row.properties">
      <xsl:variable name="bgcolor">
         <xsl:call-template name="dbfo-attribute">
            <xsl:with-param name="pis" select="processing-instruction('dbfo')" />
            <xsl:with-param name="attribute" select="'bgcolor'" />
         </xsl:call-template>
      </xsl:variable>
      <xsl:if test="$bgcolor != ''">
         <xsl:attribute name="background-color">
      <xsl:value-of select="$bgcolor" />
    </xsl:attribute>
      </xsl:if>
      <xsl:if test="ancestor::thead or ancestor::tfoot">
         <xsl:attribute name="background-color">#323863</xsl:attribute>
      </xsl:if>
   </xsl:template>

   <!--
      From: fo/titlepage.templates.xsl
      Reason: Switch to using chapter.titlepage.recto.style
      Version:1.72
   -->
   <xsl:template match="title" mode="appendix.titlepage.recto.auto.mode">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
         xsl:use-attribute-sets="chapter.titlepage.recto.style">
         <xsl:call-template name="component.title.nomarkup">
            <xsl:with-param name="node" select="ancestor-or-self::appendix[1]" />
         </xsl:call-template>
      </fo:block>
   </xsl:template>

   <!--
      From: fo/titlepage.templates.xsl
      Reason: Remove font size and weight overrides
      Version:1.72
   -->
   <xsl:template match="title" mode="chapter.titlepage.recto.auto.mode">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
         xsl:use-attribute-sets="chapter.titlepage.recto.style">
         <xsl:value-of select="." />
      </fo:block>
   </xsl:template>

   <!--
      From: fo/titlepage.templates.xsl
      Reason: Remove font family, size and weight overrides
      Version:1.72
   -->
   <xsl:template name="preface.titlepage.recto">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
         xsl:use-attribute-sets="preface.titlepage.recto.style"
         margin-left="{$title.margin.left}">
         <xsl:call-template name="component.title.nomarkup">
            <xsl:with-param name="node" select="ancestor-or-self::preface[1]" />
         </xsl:call-template>
      </fo:block>
      <xsl:choose>
         <xsl:when test="prefaceinfo/subtitle">
            <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
               select="prefaceinfo/subtitle" />
         </xsl:when>
         <xsl:when test="docinfo/subtitle">
            <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
               select="docinfo/subtitle" />
         </xsl:when>
         <xsl:when test="info/subtitle">
            <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
               select="info/subtitle" />
         </xsl:when>
         <xsl:when test="subtitle">
            <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
               select="subtitle" />
         </xsl:when>
      </xsl:choose>

      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/corpauthor" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/corpauthor" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/corpauthor" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/authorgroup" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/authorgroup" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/authorgroup" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/author" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/author" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/author" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/othercredit" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/othercredit" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/othercredit" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/releaseinfo" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/releaseinfo" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/releaseinfo" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/copyright" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/copyright" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/copyright" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/legalnotice" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/legalnotice" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/legalnotice" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/pubdate" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/pubdate" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode" select="info/pubdate" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/revision" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/revision" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/revision" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/revhistory" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/revhistory" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/revhistory" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="prefaceinfo/abstract" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="docinfo/abstract" />
      <xsl:apply-templates mode="preface.titlepage.recto.auto.mode"
         select="info/abstract" />
   </xsl:template>


   <xsl:template name="pickfont-sans">
      <xsl:variable name="font">
         <xsl:choose>
            <xsl:when test="$l10n.gentext.language = 'ja-JP'">
               <xsl:text>KochiMincho,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'ko-KR'">
               <xsl:text>BaekmukBatang,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'zh-CN'">
               <xsl:text>ARPLKaitiMGB,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'bn-IN'">
               <xsl:text>LohitBengali,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'ta-IN'">
               <xsl:text>LohitTamil,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'pa-IN'">
               <xsl:text>LohitPunjabi,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'hi-IN'">
               <xsl:text>LohitHindi,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'gu-IN'">
               <xsl:text>LohitGujarati,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'zh-TW'">
               <xsl:text>ARPLMingti2LBig5,</xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$fop1.extensions != 0">
            <xsl:copy-of select="$font" />
            <xsl:text>DejaVuLGCSans,sans-serif</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="$font" />
            <xsl:text>sans-serif</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="pickfont-serif">
      <xsl:variable name="font">
         <xsl:choose>
            <xsl:when test="$l10n.gentext.language = 'ja-JP'">
               <xsl:text>KochiMincho,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'ko-KR'">
               <xsl:text>BaekmukBatang,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'zh-CN'">
               <xsl:text>ARPLKaitiMGB,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'bn-IN'">
               <xsl:text>LohitBengali,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'ta-IN'">
               <xsl:text>LohitTamil,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'pa-IN'">
               <xsl:text>LohitPunjabi,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'hi-IN'">
               <xsl:text>LohitHindi,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'gu-IN'">
               <xsl:text>LohitGujarati,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'zh-TW'">
               <xsl:text>ARPLMingti2LBig5,</xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$fop1.extensions != 0">
            <xsl:copy-of select="$font" />
            <xsl:text>DejaVuLGCSans,serif</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="$font" />
            <xsl:text>serif</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <xsl:template name="pickfont-mono">
      <xsl:variable name="font">
         <xsl:choose>
            <xsl:when test="$l10n.gentext.language = 'ja-JP'">
               <xsl:text>KochiMincho,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'ko-KR'">
               <xsl:text>BaekmukBatang,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'zh-CN'">
               <xsl:text>ARPLKaitiMGB,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'bn-IN'">
               <xsl:text>LohitBengali,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'ta-IN'">
               <xsl:text>LohitTamil,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'pa-IN'">
               <xsl:text>LohitPunjabi,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'hi-IN'">
               <xsl:text>LohitHindi,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'gu-IN'">
               <xsl:text>LohitGujarati,</xsl:text>
            </xsl:when>
            <xsl:when test="$l10n.gentext.language = 'zh-TW'">
               <xsl:text>ARPLMingti2LBig5,</xsl:text>
            </xsl:when>
         </xsl:choose>
      </xsl:variable>
      <xsl:choose>
         <xsl:when test="$fop1.extensions != 0">
            <xsl:copy-of select="$font" />
            <xsl:text>DejaVuLGCSans,monospace</xsl:text>
         </xsl:when>
         <xsl:otherwise>
            <xsl:copy-of select="$font" />
            <xsl:text>monospace</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
   </xsl:template>

   <!--xsl:param name="symbol.font.family">
      <xsl:choose>
      <xsl:when test="$l10n.gentext.language = 'ja-JP'">
      <xsl:text>Symbol,ZapfDingbats</xsl:text>
      </xsl:when>
      <xsl:otherwise>
      <xsl:text>Symbol,ZapfDingbats</xsl:text>
      </xsl:otherwise>
      </xsl:choose>
      </xsl:param-->

   <xsl:param name="title.font.family">
      <xsl:call-template name="pickfont-sans" />
   </xsl:param>

   <xsl:param name="body.font.family">
      <xsl:call-template name="pickfont-sans" />
   </xsl:param>

   <xsl:param name="monospace.font.family">
      <xsl:call-template name="pickfont-mono" />
   </xsl:param>

   <xsl:param name="sans.font.family">
      <xsl:call-template name="pickfont-sans" />
   </xsl:param>

   <!--xsl:param name="callout.unicode.font">
      <xsl:call-template name="pickfont-sans"/>
      </xsl:param-->

   <!--
      From: fo/verbatim.xsl
      Reason: Left align address
      Version: 1.72
   -->

   <xsl:template match="address">
      <xsl:param name="suppress-numbers" select="'0'" />

      <xsl:variable name="content">
         <xsl:choose>
            <xsl:when
               test="$suppress-numbers = '0'
											and @linenumbering = 'numbered'
											and $use.extensions != '0'
											and $linenumbering.extension != '0'">
               <xsl:call-template name="number.rtf.lines">
                  <xsl:with-param name="rtf">
                     <xsl:apply-templates />
                  </xsl:with-param>
               </xsl:call-template>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates />
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <fo:block wrap-option='no-wrap' white-space-collapse='false'
         white-space-treatment='preserve' linefeed-treatment="preserve" text-align="start"
         xsl:use-attribute-sets="verbatim.properties">
         <xsl:copy-of select="$content" />
      </fo:block>
   </xsl:template>

   <xsl:template name="component.title.nomarkup">
      <xsl:param name="node" select="." />

      <xsl:variable name="id">
         <xsl:call-template name="object.id">
            <xsl:with-param name="object" select="$node" />
         </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="title">
         <xsl:apply-templates select="$node" mode="object.title.markup">
            <xsl:with-param name="allow-anchors" select="1" />
         </xsl:apply-templates>
      </xsl:variable>
      <xsl:copy-of select="$title" />
   </xsl:template>

   <!--
      From: fo/pagesetup.xsl
      Reason: Custom Header
      Version: 1.72
   -->
   <!--Style for header-->
      <xsl:template name="header.content">
      <xsl:param name="pageclass" select="''" />
      <xsl:param name="sequence" select="''" />
      <xsl:param name="position" select="''" />
      <xsl:param name="gentext-key" select="''" />

      <xsl:choose>
         <xsl:when test="$sequence = 'blank'">
            <!-- nothing -->
         </xsl:when>
         <!-- Extracting 'Chapter' + Chapter Number from the full Chapter title, with a dirty, dirty hack -->
         <xsl:when test="($position='left' and $gentext-key='chapter')">
            <xsl:variable name="text">
               <xsl:call-template name="component.title.nomarkup" />
            </xsl:variable>
            <xsl:variable name="chapt">
               <xsl:value-of select="substring-before($text, '&#xA0;')" />
            </xsl:variable>
            <xsl:variable name="remainder">
               <xsl:value-of select="substring-after($text, '&#xA0;')" />
            </xsl:variable>
            <xsl:variable name="chapt-num">
               <xsl:value-of select="substring-before($remainder, '&#xA0;')" />
            </xsl:variable>
            <xsl:variable name="text1">
               <xsl:value-of select="concat(substring($text, 0), '')"  />
            </xsl:variable>
            <fo:inline keep-together.within-line="always" font-weight="bold" color="#285A92" font-size="9pt">
               <xsl:value-of select="$text1" />
            </fo:inline>
         </xsl:when>
      
         <xsl:when test="($sequence='even' and $position='left')">
            <xsl:variable name="text">
               <xsl:call-template name="component.title.nomarkup" />
            </xsl:variable>
            <fo:inline keep-together.within-line="always" font-weight="bold" color="#285A92" font-size="9pt">
               <xsl:choose>
                  <xsl:when test="string-length($text) &gt; '33'">
                     <xsl:value-of
                        select="concat(substring($text, 0), '')" />
                  </xsl:when>
                  <xsl:otherwise>
                     <xsl:value-of select="$text" />
                  </xsl:otherwise>
               </xsl:choose>
            </fo:inline>
         </xsl:when>
         <xsl:when test="($sequence='odd' and $position='right')">
            <fo:inline keep-together.within-line="always" color="#285A92" font-size="9pt">
               <fo:retrieve-marker retrieve-class-name="section.head.marker"
                  retrieve-position="first-including-carryover"
                  retrieve-boundary="page-sequence" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="($position='right')">
            <fo:inline keep-together.within-line="always" color="#285A92" font-size="9pt" font-style="italic">
             eXo Platform 4.0
            </fo:inline>
         </xsl:when>
      </xsl:choose>
   </xsl:template>

   <!--
      From: fo/pagesetup.xsl
      Reason: Override colour
      Version: 1.72
   -->
   <xsl:template name="head.sep.rule">
      <xsl:param name="pageclass" />
      <xsl:param name="sequence" />
      <xsl:param name="gentext-key" />

      <xsl:if test="$header.rule != 0">
         <xsl:attribute name="border-bottom-width">1pt</xsl:attribute>
         <xsl:attribute name="border-bottom-style">solid</xsl:attribute>
         <xsl:attribute name="border-bottom-color">#285A92</xsl:attribute>
      </xsl:if>
   </xsl:template>

   <!--
      From: fo/pagesetup.xsl
      Reason: Override colour
      Version: 1.72
   -->
   <xsl:template name="foot.sep.rule">
      <xsl:param name="pageclass" />
      <xsl:param name="sequence" />
      <xsl:param name="gentext-key" />

      <xsl:if test="$footer.rule != 0">
         <xsl:attribute name="border-top-width">0.5pt</xsl:attribute>
         <xsl:attribute name="border-top-style">solid</xsl:attribute>
         <xsl:attribute name="border-top-color">#285A92</xsl:attribute>
      </xsl:if>
   </xsl:template>

   <!-- Define style for footer -->

    <!--Text appearance in footers -->
	<xsl:attribute-set name="footer.content.properties">
	  <xsl:attribute name="font-style">italic</xsl:attribute>
	  <xsl:attribute name="font-size">8pt</xsl:attribute>
	</xsl:attribute-set>

    <!--Insert copyright text to footer -->
	<xsl:template name="footer.content">
		<xsl:param name="pageclass" select="''"/>
		<xsl:param name="sequence" select="''"/>
		<xsl:param name="position" select="''"/>
		<fo:block>  
			<xsl:choose>
				<xsl:when test="$pageclass = 'titlepage'">
				<!--no footer on title pages-->
				</xsl:when>
				<xsl:when test="$position = 'left'">
				<xsl:apply-templates select="//copyright[1]" mode="titlepage.mode"/>
				</xsl:when>
				<xsl:when test="$position = 'right'">
				<xsl:apply-templates select="." mode="titleabbrev.markup"/>
				</xsl:when>
				<xsl:when test="$position = 'center'">
				p.<fo:page-number/>
				</xsl:when>
				<xsl:when test="$sequence = 'blank'">
				</xsl:when>
				<xsl:when test="$sequence = 'odd'">
				</xsl:when>
				<xsl:when test="$sequence = 'even'">
				</xsl:when>
			</xsl:choose>
		</fo:block>
	</xsl:template>

   <xsl:param name="footnote.font.size">
      <xsl:value-of select="$body.font.master * 0.8" />
      <xsl:text>pt</xsl:text>
   </xsl:param>
   <xsl:param name="footnote.number.format" select="'1'" />
   <xsl:param name="footnote.number.symbols" select="''" />
   <xsl:attribute-set name="footnote.mark.properties">
      <xsl:attribute name="font-size">75%</xsl:attribute>
      <xsl:attribute name="font-weight">normal</xsl:attribute>
      <xsl:attribute name="font-style">normal</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="footnote.properties">
      <xsl:attribute name="padding-top">48pt</xsl:attribute>
      <xsl:attribute name="font-family"><xsl:value-of select="$body.fontset" />
      </xsl:attribute>
      <xsl:attribute name="font-size"><xsl:value-of select="$footnote.font.size" />
      </xsl:attribute>
      <xsl:attribute name="font-weight">normal</xsl:attribute>
      <xsl:attribute name="font-style">normal</xsl:attribute>
      <xsl:attribute name="text-align"><xsl:value-of select="$alignment" />
      </xsl:attribute>
      <xsl:attribute name="start-indent">0pt</xsl:attribute>
   </xsl:attribute-set>
   <xsl:attribute-set name="footnote.sep.leader.properties">
      <xsl:attribute name="color">black</xsl:attribute>
      <xsl:attribute name="leader-pattern">rule</xsl:attribute>
      <xsl:attribute name="leader-length">1in</xsl:attribute>
   </xsl:attribute-set>

   <xsl:template match="author" mode="tablerow.titlepage.mode">
      <fo:table-row>
         <fo:table-cell>
            <fo:block>
               <xsl:call-template name="gentext">
                  <xsl:with-param name="key" select="'Author'" />
               </xsl:call-template>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell>
            <fo:block>
               <xsl:call-template name="person.name">
                  <xsl:with-param name="node" select="." />
               </xsl:call-template>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell>
            <fo:block>
               <xsl:apply-templates select="email" />
            </fo:block>
         </fo:table-cell>
      </fo:table-row>
   </xsl:template>

   <xsl:template match="author" mode="titlepage.mode">
      <fo:block>
         <xsl:call-template name="person.name">
            <xsl:with-param name="node" select="." />
         </xsl:call-template>
      </fo:block>
   </xsl:template>

   <xsl:param name="editedby.enabled">0</xsl:param>

   <xsl:template match="editor" mode="tablerow.titlepage.mode">
      <fo:table-row>
         <fo:table-cell>
            <fo:block>
               <xsl:call-template name="gentext">
                  <xsl:with-param name="key" select="'Editor'" />
               </xsl:call-template>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell>
            <fo:block>
               <xsl:call-template name="person.name">
                  <xsl:with-param name="node" select="." />
               </xsl:call-template>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell>
            <fo:block>
               <xsl:apply-templates select="email" />
            </fo:block>
         </fo:table-cell>
      </fo:table-row>
   </xsl:template>

   <xsl:template match="othercredit" mode="tablerow.titlepage.mode">
      <fo:table-row>
         <fo:table-cell>
            <fo:block>
               <xsl:call-template name="gentext">
                  <xsl:with-param name="key" select="'translator'" />
               </xsl:call-template>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell>
            <fo:block>
               <xsl:call-template name="person.name">
                  <xsl:with-param name="node" select="." />
               </xsl:call-template>
            </fo:block>
         </fo:table-cell>
         <fo:table-cell>
            <fo:block>
               <xsl:apply-templates select="email" />
            </fo:block>
         </fo:table-cell>
      </fo:table-row>
   </xsl:template>

   <!--
      From: fo/titlepage.xsl
      Reason: 
      Version:1.72
   -->
   <!-- Omitted to get JBossOrg style working - TODO
      <xsl:template name="verso.authorgroup">
      <fo:table table-layout="fixed" width="100%">
      <fo:table-column column-number="1" column-width="proportional-column-width(1)"/>
      <fo:table-column column-number="2" column-width="proportional-column-width(1)"/>
      <fo:table-column column-number="3" column-width="proportional-column-width(1)"/>
      <fo:table-body>
      <xsl:apply-templates select="author" mode="tablerow.titlepage.mode"/>
      <xsl:apply-templates select="editor" mode="tablerow.titlepage.mode"/>
      <xsl:apply-templates select="othercredit" mode="tablerow.titlepage.mode"/>
      </fo:table-body>
      </fo:table>
      </xsl:template> -->

   <xsl:template match="title" mode="book.titlepage.recto.auto.mode">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
         xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center"
         font-size="20pt" space-before="18.6624pt" font-weight="bold"
         font-family="{$title.fontset}">
         <xsl:call-template name="division.title">
            <xsl:with-param name="node" select="ancestor-or-self::book[1]" />
         </xsl:call-template>
      </fo:block>
   </xsl:template>

   <xsl:template match="subtitle" mode="book.titlepage.recto.auto.mode">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
         xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center"
         font-size="17pt" space-before="10pt" font-style="italic" font-family="{$title.fontset}">
         <xsl:apply-templates select="." mode="book.titlepage.recto.mode" />
      </fo:block>
   </xsl:template>
	
	<!--Style for Copyright -->
	<xsl:template match="copyright" mode="book.titlepage.recto.auto.mode">
		<fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
		xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center"
		font-size="9pt" space-before="10pt" font-style="italic" font-family="{$title.fontset}">
		<xsl:apply-templates select="." mode="book.titlepage.recto.mode" />
		</fo:block>
	</xsl:template>

   <xsl:template match="issuenum" mode="book.titlepage.recto.auto.mode">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format"
         xsl:use-attribute-sets="book.titlepage.recto.style" text-align="center"
         font-size="16pt" space-before="15.552pt" font-family="{$title.fontset}">
         <xsl:apply-templates select="." mode="book.titlepage.recto.mode" />
      </fo:block>
   </xsl:template>

   <xsl:template match="author" mode="book.titlepage.recto.auto.mode">
      <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" font-size="14pt"
         space-before="15.552pt">
         <xsl:call-template name="person.name">
            <xsl:with-param name="node" select="." />
         </xsl:call-template>
      </fo:block>
   </xsl:template>

   <!-- <xsl:template name="book.titlepage.recto">
      <xsl:choose>
      <xsl:when test="bookinfo/title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/title"/>
      </xsl:when>
      <xsl:when test="info/title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/title"/>
      </xsl:when>
      <xsl:when test="title">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="title"/>
      </xsl:when>
      </xsl:choose>
      
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/issuenum"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/issuenum"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="issuenum"/>
      
      <xsl:choose>
      <xsl:when test="bookinfo/subtitle">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/subtitle"/>
      </xsl:when>
      <xsl:when test="info/subtitle">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/subtitle"/>
      </xsl:when>
      <xsl:when test="subtitle">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="subtitle"/>
      </xsl:when>
      </xsl:choose>
      
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/corpauthor"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/corpauthor"/>
      
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/authorgroup/author"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/authorgroup/author"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/author"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/author"/>
      
      <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" color="black">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/invpartnumber"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/invpartnumber"/>
      </fo:block>
      <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" color="black">
      <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'isbn'"/>
      </xsl:call-template>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/isbn"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/isbn"/>
      </fo:block>
      <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" color="black"> 
      <xsl:call-template name="gentext">
      <xsl:with-param name="key" select="'pubdate'"/>
      </xsl:call-template>
      <xsl:text>: </xsl:text>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/pubdate"/>
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/pubdate"/>
      </fo:block>
      </xsl:template> -->

   <!-- Use our own slightly simpler title page (just show title, version, authors) -->
   <xsl:template name="book.titlepage.recto">
      <xsl:choose>
         <xsl:when test="bookinfo/title">
            <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
               select="bookinfo/title" />
         </xsl:when>
         <xsl:when test="info/title">
            <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
               select="info/title" />
         </xsl:when>
         <xsl:when test="title">
            <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="title" />
         </xsl:when>
      </xsl:choose>

      <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
         select="bookinfo/issuenum" />
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="info/issuenum" />
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="issuenum" />

      <xsl:choose>
         <xsl:when test="bookinfo/subtitle">
            <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
               select="bookinfo/subtitle" />
         </xsl:when>
         <xsl:when test="info/subtitle">
            <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
               select="info/subtitle" />
         </xsl:when>
         <xsl:when test="subtitle">
            <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="subtitle" />
         </xsl:when>
      </xsl:choose>
	  <xsl:choose>
		<xsl:when test="bookinfo/copyright">
		  <xsl:apply-templates mode="book.titlepage.recto.auto.mode" select="bookinfo/copyright" />
		</xsl:when>
	  </xsl:choose>
      <fo:block xsl:use-attribute-sets="book.titlepage.recto.style" font-size="14pt"
         space-before="15.552pt">
         <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
            select="bookinfo/releaseinfo" />
      </fo:block>

      <fo:block text-align="center" space-before="15.552pt">
         <xsl:call-template name="person.name.list">
            <xsl:with-param name="person.list"
               select="bookinfo/authorgroup/author|bookinfo/authorgroup/corpauthor" />
            <xsl:with-param name="person.type" select="'author'" />
         </xsl:call-template>
      </fo:block>

      <fo:block text-align="center" space-before="15.552pt">
         <xsl:call-template name="person.name.list">
            <xsl:with-param name="person.list" select="bookinfo/authorgroup/editor" />
            <xsl:with-param name="person.type" select="'editor'" />
         </xsl:call-template>
      </fo:block>

      <fo:block text-align="center" space-before="15.552pt">
         <xsl:call-template name="person.name.list">
            <xsl:with-param name="person.list" select="bookinfo/authorgroup/othercredit" />
            <xsl:with-param name="person.type" select="'othercredit'" />
         </xsl:call-template>
      </fo:block>

   </xsl:template>

  <xsl:template name="book.titlepage.verso">
    <xsl:choose>
      <xsl:when test="bookinfo/abstract">
        <xsl:apply-templates mode="titlepage.mode" select="bookinfo/abstract"/>
      </xsl:when>
      <xsl:when test="info/abstract">
        <xsl:apply-templates mode="titlepage.mode" select="info/abstract"/>
      </xsl:when>
    </xsl:choose>

  </xsl:template>



   <!-- <xsl:template name="book.titlepage3.recto">
      <xsl:choose>
      <xsl:when test="bookinfo/title">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/title"/>
      </xsl:when>
      <xsl:when test="info/title">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/title"/>
      </xsl:when>
      <xsl:when test="title">
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="title"/>
      </xsl:when>
      </xsl:choose>

      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/authorgroup"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/authorgroup"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/author"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/author"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/othercredit"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/othercredit"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/copyright"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/copyright"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/legalnotice"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/legalnotice"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="bookinfo/publisher"/>
      <xsl:apply-templates mode="book.titlepage.verso.auto.mode" select="info/publisher"/>
      </xsl:template> -->

   <xsl:template name="book.titlepage3.recto">

   </xsl:template>

   <!-- Make examples, tables etc. break across pages -->
   <xsl:attribute-set name="formal.object.properties">
      <xsl:attribute name="keep-together.within-column">auto</xsl:attribute>
   </xsl:attribute-set>

   <!-- Correct placement of titles for figures and examples. -->
   <xsl:param name="formal.title.placement">
      figure after example before equation before table before procedure before
   </xsl:param>

   <!-- Prevent blank pages in output -->
   <xsl:template name="book.titlepage.before.verso"></xsl:template>
   <xsl:template name="book.titlepage.separator"></xsl:template>

   <!-- <xsl:template name="book.titlepage.separator"><fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
      </xsl:template> -->

   <xsl:template name="book.titlepage.before.recto"></xsl:template>

   <!-- <xsl:template name="book.titlepage.before.verso"><fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format" break-after="page"/>
      </xsl:template> -->

   <xsl:template name="book.titlepage">
      <fo:block xmlns:fo="http://www.w3.org/1999/XSL/Format">
         <xsl:call-template name="book.titlepage.before.recto" />
         <fo:block>
            <xsl:call-template name="book.titlepage.recto" />
         </fo:block>
         <xsl:call-template name="book.titlepage.separator" />
         <fo:block>
            <xsl:call-template name="book.titlepage.verso" />
         </fo:block>
         <xsl:call-template name="book.titlepage.separator" />
         <fo:block>
            <xsl:call-template name="book.titlepage3.recto" />
         </fo:block>
         <xsl:call-template name="book.titlepage.separator" />
      </fo:block>
   </xsl:template>

   <!--
      From: fo/qandaset.xsl
      Reason: Id in list-item-label causes fop crash
      Version:1.72
   -->

   <xsl:template match="question">
      <xsl:variable name="id">
         <xsl:call-template name="object.id" />
      </xsl:variable>

      <xsl:variable name="entry.id">
         <xsl:call-template name="object.id">
            <xsl:with-param name="object" select="parent::*" />
         </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="deflabel">
         <xsl:choose>
            <xsl:when test="ancestor-or-self::*[@defaultlabel]">
               <xsl:value-of
                  select="(ancestor-or-self::*[@defaultlabel])[last()]
                              /@defaultlabel" />
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$qanda.defaultlabel" />
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <fo:list-item id="{$entry.id}" xsl:use-attribute-sets="list.item.spacing">
         <fo:list-item-label end-indent="label-end()">
            <xsl:choose>
               <xsl:when test="$deflabel = 'none'">
                  <fo:block />
               </xsl:when>
               <xsl:otherwise>
                  <fo:block>
                     <xsl:apply-templates select="." mode="label.markup" />
                     <xsl:if test="$deflabel = 'number' and not(label)">
                        <xsl:apply-templates select="." mode="intralabel.punctuation" />
                     </xsl:if>
                  </fo:block>
               </xsl:otherwise>
            </xsl:choose>
         </fo:list-item-label>
         <fo:list-item-body start-indent="body-start()">
            <xsl:choose>
               <xsl:when test="$deflabel = 'none'">
                  <fo:block font-weight="bold">
                     <xsl:apply-templates select="*[local-name(.)!='label']" />
                  </fo:block>
               </xsl:when>
               <xsl:otherwise>
                  <xsl:apply-templates select="*[local-name(.)!='label']" />
               </xsl:otherwise>
            </xsl:choose>
            <!-- Uncomment this line to get revhistory output in the question -->
            <!-- <xsl:apply-templates select="preceding-sibling::revhistory"/> -->
         </fo:list-item-body>
      </fo:list-item>
   </xsl:template>

   <!--
      From: fo/qandaset.xsl
      Reason: Id in list-item-label causes fop crash
      Version:1.72
   -->
   <xsl:template match="answer">
      <xsl:variable name="id">
         <xsl:call-template name="object.id" />
      </xsl:variable>
      <xsl:variable name="entry.id">
         <xsl:call-template name="object.id">
            <xsl:with-param name="object" select="parent::*" />
         </xsl:call-template>
      </xsl:variable>

      <xsl:variable name="deflabel">
         <xsl:choose>
            <xsl:when test="ancestor-or-self::*[@defaultlabel]">
               <xsl:value-of
                  select="(ancestor-or-self::*[@defaultlabel])[last()]
                              /@defaultlabel" />
            </xsl:when>
            <xsl:otherwise>
               <xsl:value-of select="$qanda.defaultlabel" />
            </xsl:otherwise>
         </xsl:choose>
      </xsl:variable>

      <fo:list-item xsl:use-attribute-sets="list.item.spacing">
         <fo:list-item-label end-indent="label-end()">
            <xsl:choose>
               <xsl:when test="$deflabel = 'none'">
                  <fo:block />
               </xsl:when>
               <xsl:otherwise>
                  <fo:block>
                     <xsl:variable name="answer.label">
                        <xsl:apply-templates select="." mode="label.markup" />
                     </xsl:variable>
                     <xsl:copy-of select="$answer.label" />
                  </fo:block>
               </xsl:otherwise>
            </xsl:choose>
         </fo:list-item-label>
         <fo:list-item-body start-indent="body-start()">
            <xsl:apply-templates select="*[local-name(.)!='label']" />
         </fo:list-item-body>
      </fo:list-item>
   </xsl:template>


   <xsl:template
      match="programlisting|programlisting[@language='XML']|programlisting[@language='JAVA']|programlisting[@language='XHTML']|programlisting[@language='JSP']|programlisting[@language='CSS']">

    <xsl:variable name="language">
      <xsl:value-of select="s:toUpperCase(string(@language))"
            xmlns:s="java:java.lang.String" />
      </xsl:variable>

      <xsl:variable name="hilighter" select="jbh:new()" />
    <xsl:variable name="parsable" select="jbh:isParsable($language)"/>

      <fo:block background-color="#F5F5F5" border-style="solid" border-width=".3mm"
         border-color="#CCCCCC" font-family="{$programlisting.font}"
         font-size="{$programlisting.font.size}" space-before="12pt" space-after="12pt"
         linefeed-treatment="preserve" white-space-collapse="false"
         white-space-treatment="preserve" padding-bottom="5pt" padding-top="5pt"
         padding-right="12pt" padding-left="12pt" padding="20pt" margin="0">

         <xsl:choose>
            <xsl:when test="$parsable = 'true'">
               <xsl:for-each select="node()">
                  <xsl:choose>
                     <xsl:when test="self::text()">
                        <xsl:variable name="child.content" select="." />

                        <xsl:variable name="caller"
                           select="jbh:parseText($hilighter, $language, string($child.content), 'UTF-8')" />
                        <xsl:variable name="noOfTokens"
                           select="jbh:getNoOfTokens($caller)" />

                        <xsl:call-template name="iterator">
                           <xsl:with-param name="caller" select="$caller" />
                           <xsl:with-param name="noOfTokens" select="$noOfTokens" />
                        </xsl:call-template>
                     </xsl:when>
                     <xsl:otherwise>
                        <fo:inline>
                           <xsl:call-template name="anchor" />
                        </fo:inline>
                     </xsl:otherwise>
                  </xsl:choose>
               </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
               <xsl:apply-templates />
            </xsl:otherwise>
         </xsl:choose>

      </fo:block>
   </xsl:template>


   <xsl:template name="iterator">
      <xsl:param name="caller" />
      <xsl:param name="noOfTokens" />
      <xsl:param name="i" select="0" />

      <xsl:variable name="style" select="jbh:getStyle($caller, $i)" />
      <xsl:variable name="token" select="jbh:getToken($caller, $i)" />

      <xsl:choose>
         <xsl:when test="$style = 'java_keyword'">
            <fo:inline color="#7F1B55" font-weight="bold">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_plain'">
            <fo:inline color="#000000">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_type'">
            <fo:inline color="#000000">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_separator'">
            <fo:inline color="#000000">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_literal'">
            <fo:inline color="#2A00FF">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_comment'">
            <fo:inline color="#3F7F5F">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_javadoc_comment'">
            <fo:inline color="#3F5FBF" font-style="italic">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_operator'">
            <fo:inline color="#000000">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'java_javadoc_tag'">
            <fo:inline color="#7F9FBF" font-weight="bold" font-style="italic">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_plain'">
            <fo:inline color="#000000">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_char_data'">
            <fo:inline color="#000000">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_tag_symbols'">
            <fo:inline color="#008080">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_comment'">
            <fo:inline color="#3F5FBF">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_attribute_value'">
            <fo:inline color="#2A00FF">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_attribute_name'">
            <fo:inline color="#7F007F" font-weight="bold">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_processing_instruction'">
            <fo:inline color="#000000" font-weight="bold" font-style="italic">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_tag_name'">
            <fo:inline color="#3F7F7F">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_rife_tag'">
            <fo:inline color="#000000">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:when test="$style = 'xml_rife_name'">
            <fo:inline color="#008CCA">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:when>
         <xsl:otherwise>
            <fo:inline color="black">
               <xsl:value-of select="$token" />
            </fo:inline>
         </xsl:otherwise>
      </xsl:choose>

      <xsl:if test="$i &lt; $noOfTokens - 1">
         <xsl:call-template name="iterator">
            <xsl:with-param name="caller" select="$caller" />
            <xsl:with-param name="noOfTokens" select="$noOfTokens" />
            <xsl:with-param name="i" select="$i + 1" />
         </xsl:call-template>
      </xsl:if>
   </xsl:template>
   
   <xsl:template match="abstract">
  <xsl:variable name="keep.together">
  </xsl:variable>
  <fo:block xsl:use-attribute-sets="normal.para.spacing" background-color="#f8f8f8" padding="20pt" margin="0pt" border="1px solid #cfcfcf">
    <xsl:if test="$keep.together != ''">
      <xsl:attribute name="keep-together.within-column"><xsl:value-of
                      select="$keep.together"/></xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>
  </fo:block>
</xsl:template>

  <xsl:template match="abstract" mode="titlepage.mode">
    <xsl:variable name="keep.together">
    </xsl:variable>
    <fo:block xsl:use-attribute-sets="normal.para.spacing" background-color="#f8f8f8" padding="20pt" margin="0pt" border="1px solid #cfcfcf">
      <xsl:if test="$keep.together != ''">
        <xsl:attribute name="keep-together.within-column">
          <xsl:value-of
                  select="$keep.together"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:call-template name="anchor"/>
      <xsl:apply-templates/>
    </fo:block>
  </xsl:template>

<xsl:template match="prompt">
  <xsl:param name="content">
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>
  <fo:inline color="#888888" font-family="Lucida Sans,Tahoma,Verdana,Arial,Helvetica,sans-serif" font-size="9pt">
    <xsl:call-template name="anchor"/>
    <xsl:if test="@dir">
      <xsl:attribute name="direction">
        <xsl:choose>
          <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
          <xsl:otherwise>rtl</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>

<xsl:template match="citetitle">
  <xsl:param name="content">
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>
  <fo:inline color="#0C46BC" font-style="normal" font-size="9pt">
    <xsl:call-template name="anchor"/>
    <xsl:if test="@dir">
      <xsl:attribute name="direction">
        <xsl:choose>
          <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
          <xsl:otherwise>rtl</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>


<xsl:template match="code">
  <xsl:param name="content">
    <xsl:call-template name="inline.monoseq">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>
  <fo:inline background-color="#FEE9CC" font-size="12pt">
    <xsl:call-template name="anchor"/>
    <xsl:if test="@dir">
      <xsl:attribute name="direction">
        <xsl:choose>
          <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
          <xsl:otherwise>rtl</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>


<xsl:template match="screen">    
  <xsl:variable name="keep.together">
  </xsl:variable>
  <fo:block font-family="Verdana,Arial,Sans-serif" color="#393939" background-color="#F4F4F4" font-size="8pt" space-before="10pt" space-after="10pt"
         linefeed-treatment="preserve" white-space-collapse="false"
         white-space-treatment="preserve" padding-bottom="7pt" padding-top="7pt"
         padding-right="10pt" padding-left="10pt" margin="0">        
	<xsl:if test="$keep.together != ''">
      <xsl:attribute name="keep-together.within-column"><xsl:value-of
                      select="$keep.together"/></xsl:attribute>
    </xsl:if>
    <xsl:call-template name="anchor"/>
    <xsl:apply-templates/>	
  </fo:block>
</xsl:template>
 
 <xsl:template match="term">
  <xsl:param name="content">
    <xsl:call-template name="simple.xlink">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>
  <fo:inline color="#2E398C" font-style="normal" font-size="9pt">
    <xsl:call-template name="anchor"/>
    <xsl:if test="@dir">
      <xsl:attribute name="direction">
        <xsl:choose>
          <xsl:when test="@dir = 'ltr' or @dir = 'lro'">ltr</xsl:when>
          <xsl:otherwise>rtl</xsl:otherwise>
        </xsl:choose>
      </xsl:attribute>
    </xsl:if>
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>
 
<!-- template for guibutton & guilabel -->

<xsl:template match="guibutton">
  <xsl:param name="content">
    <xsl:call-template name="inline.boldseq">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>
  <fo:inline background-color="#e8e6e6" padding-right="2pt" color="#383838" font-size="9pt">      
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template> 
 
<xsl:template match="guilabel">
  <xsl:param name="content">
    <xsl:call-template name="inline.boldseq">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>
    </xsl:call-template>
  </xsl:param>
  <fo:inline padding-right="2pt" color="#383838" font-size="9pt" letter-spacing="1pt">      
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template> 


<!--
  From: fo/table.xsl
  Reason: Remove Table Heading
  Version:1.76
-->
<xsl:template name="table.block">
  <xsl:param name="table.layout" select="NOTANODE"/>
  <xsl:variable name="id">
    <xsl:call-template name="object.id"/>
  </xsl:variable>
  <xsl:variable name="keep.together">
  </xsl:variable>
  <xsl:choose>
    <xsl:when test="self::table">
      <fo:block id="{$id}"
                xsl:use-attribute-sets="table.properties">
        <xsl:if test="$keep.together != ''">
          <xsl:attribute name="keep-together.within-column">
            <xsl:value-of select="$keep.together"/>
          </xsl:attribute>
        </xsl:if>
        <xsl:copy-of select="$table.layout"/>
        <xsl:call-template name="table.footnote.block"/>
      </fo:block>
    </xsl:when>
    <xsl:otherwise>
      <fo:block id="{$id}"
                xsl:use-attribute-sets="informaltable.properties">
        <xsl:copy-of select="$table.layout"/>
        <xsl:call-template name="table.footnote.block"/>
      </fo:block>
    </xsl:otherwise>
  </xsl:choose>
</xsl:template>

<xsl:template match="highlights">
 <xsl:variable name="keep.together">
 </xsl:variable>
 <fo:block xsl:use-attribute-sets="normal.para.spacing" background-color="white" padding="0px 5px 7px" border-left="1.5px dotted #CCCCCC" margin-bottom="10px">
	<xsl:if test="$keep.together != ''">
		<xsl:attribute name="keep-together.within-column"><xsl:value-of select="$keep.together"/></xsl:attribute>
    </xsl:if>
  <xsl:call-template name="anchor"/>
  <xsl:apply-templates/>
 </fo:block>
</xsl:template>

<!-- set the menuchoice separator character-->   	  	
<xsl:param name="menuchoice.menu.separator"><fo:inline color="#383838"> --> </fo:inline></xsl:param>

<xsl:template match="guimenu"> 	 
  <xsl:param name="content"> 	 
    <xsl:call-template name="inline.boldseq"> 	 
      <xsl:with-param name="content"> 	 
        <xsl:apply-templates/> 	 
      </xsl:with-param> 	 
    </xsl:call-template> 	 
  </xsl:param> 	 
  <fo:inline padding-right="2pt" color="#383838" font-size="9pt" letter-spacing="1pt">      
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template> 	

<xsl:template match="guisubmenu">
  <xsl:param name="content">
    <xsl:call-template name="inline.boldseq">
      <xsl:with-param name="content">
        <xsl:apply-templates/>
      </xsl:with-param>	
    </xsl:call-template>
  </xsl:param>
  <fo:inline padding-right="2pt" color="#383838" font-size="9pt" letter-spacing="1pt">       	
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template> 

<xsl:template match="guimenuitem">
  <xsl:param name="content">
    <xsl:call-template name="inline.boldseq">
      <xsl:with-param name="content">
        <xsl:apply-templates/>	
      </xsl:with-param>
    </xsl:call-template>	
  </xsl:param>	
  <fo:inline padding-right="2pt" color="#383838" font-size="9pt" letter-spacing="1pt">      	
    <xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>

<xsl:template match="command"> 	 
  <xsl:param name="content"> 	 
    <xsl:call-template name="inline.monoseq"> 	 
      <xsl:with-param name="content"> 	 
        <xsl:apply-templates/> 	 
      </xsl:with-param> 	 
    </xsl:call-template> 	 
  </xsl:param> 	 
  <fo:inline background-color="#F8F8F8" font-size="16px" font-family="verdana,helvetica,sans-serif" font-style="italic" font-weight="bold">
<xsl:copy-of select="$content"/>
  </fo:inline>
</xsl:template>

<xsl:template match="filename"> 	 
	<xsl:param name="content">
		<xsl:call-template name="inline.monoseq">
			<xsl:with-param name="content">
				<xsl:apply-templates/>
			</xsl:with-param> 	 
		</xsl:call-template>
	</xsl:param>
	<fo:inline font-size="16px" letter-spacing="0.1pt" font-family="verdana,helvetica,sans-serif" font-weight="bold">      
		<xsl:copy-of select="$content"/>
	</fo:inline> 	 
</xsl:template> 

</xsl:stylesheet>


