<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html"/>

<xsl:template match="html">
	<xsl:apply-templates select="body/*"/>
</xsl:template>

<xsl:template match="div[@class='crosslinks']" />

<xsl:template match="node()">
	<xsl:copy>
		<xsl:apply-templates/>
	</xsl:copy>
</xsl:template>

    <xsl:template match="node()|@*">
        <xsl:copy>
            <xsl:apply-templates select="node()|@*"/>
        </xsl:copy>
    </xsl:template>


</xsl:stylesheet>

