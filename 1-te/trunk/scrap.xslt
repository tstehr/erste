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

