<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd">
<url><loc>${urlBase}/</loc><changefreq>daily</changefreq><priority>1.00</priority></url>
<#list mountPoints as mountPoint>
  <!-- categories -->
  <#list categories as category>
    <#if "CATALOG_CATEGORY" == category.productCategoryTypeId>
      <url><loc>${urlBase}${mountPoint}control/category/~category_id=${category.productCategoryId}</loc><changefreq>daily</changefreq><priority>0.85</priority></url>
    </#if>
  </#list>
  <!-- products -->
  <#list products as product>
    <url><loc>${urlBase}${mountPoint}products/${product.productCategoryId}/${product.productId}</loc><changefreq>daily</changefreq><priority>0.85</priority></url>
  </#list>
</#list>
</urlset>