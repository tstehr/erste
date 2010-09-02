<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output encoding="UTF-8"
              method="xml"
              omit-xml-declaration="yes"
              indent="yes" />


<!-- Select the top level element "html" and only process the children of the "body" child, removing "head" etc. -->
<xsl:template match="html">
	<xsl:apply-templates select="body/*"/>
</xsl:template>

<!-- Remove the crosslinks div by not outputting anything -->
<xsl:template match="div[@class='crosslinks']" />

<!-- Links that link to "1-te..." are modified -->
<xsl:template match="a[starts-with(@href,'1-te')]">
	<a href="/index.php/die-erste/{translate(@href,'.','-')}">
		<xsl:apply-templates/>
	</a>
</xsl:template>

<!-- Anchors typically have no content - but it's not allowed to leave them empty or the a will FUCK UP the whole page. It's the same thing as with empty divs that always annoyes me. This just adds &#8203; to the output, which is a zero width space. It is all in one line to prevent the normal whitespace to show up. I LOVE this web stuff, it is so much fun. -->
<xsl:template match="a[count(child::text())=0]"><xsl:copy><xsl:apply-templates select="node()|@*"/>&#8203;</xsl:copy></xsl:template>

<!-- src-Attributes usually point to static files - those are located in another directory -->
<xsl:template match="img">
	<img src="http://fginfo.cs.tu-bs.de/1te/{@src}" alt="(Hier sollte ein Bild sein, nämlich http://fginfo.cs.tu-bs.de/1te/{@src})" />
</xsl:template>

<!-- Change heading levels. The blog only displays h1 and h2 in a beautiful way. Maybe we should convince it to do it for h3, too. -->
<xsl:template match="h3">
	<h1><xsl:apply-templates/></h1>
</xsl:template>
<xsl:template match="h4">
	<h2><xsl:apply-templates/></h2>
</xsl:template>
<xsl:template match="h5">
	<h3><xsl:apply-templates/></h3>
</xsl:template>




<!-- Copies all nodes to the output -->
<xsl:template match="node()">
	<xsl:copy>
		<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

<!-- Copies all attributes to the output -->
    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>



</xsl:stylesheet>

