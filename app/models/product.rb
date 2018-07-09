class Product < FishbowlDbBase
  self.table_name = "product"
  self.primary_key = "id"
  
  class << self
    def inventory_by_product_tree(product_tree_id)
      custom_sql = "SELECT product.num, product.description,
            sum(tag.qty) as Quantity, uom.code, TRACKING.TRACKVALUE as trackValue
        FROM tag
            INNER JOIN part ON part.ID = tag.PARTID
            INNER JOIN uom ON uom.id = part.uomid
            INNER JOIN product ON product.PARTID = part.ID
            LEFT OUTER JOIN producttotree ON producttotree.PRODUCTID = product.ID
            LEFT OUTER JOIN producttree ON producttotree.PRODUCTTREEID = producttree.ID
            LEFT OUTER JOIN (SELECT partrackinfo.tagid AS tagid, GROUP_CONCAT(partrackinfo.trackValue, '~') AS trackValue
                            FROM (SELECT tagtrackingview.tagid AS tagid, CONCAT(parttracking.abbr , ': ' ,
                                    GROUP_CONCAT((CASE
                                        WHEN tagTrackingview.typeid = 10 THEN tagtrackingview.info
                                        WHEN tagTrackingview.typeid = 20 THEN SUBSTRING(tagTrackingview.info FROM 1 FOR 11)
                                        WHEN tagTrackingview.typeid = 30 THEN SUBSTRING(tagTrackingview.info FROM 1 FOR 11)
                                        WHEN tagTrackingview.typeid = 40 THEN tagserialview.serialnum
                                        WHEN tagTrackingview.typeid = 50 THEN CAST(tagTrackingview.info as DECIMAL(18,2))
                                        WHEN tagTrackingview.typeid = 60 THEN CAST(tagTrackingview.info as DECIMAL(18,5))
                                        WHEN tagTrackingview.typeid = 70 THEN tagTrackingview.info
                                        WHEN tagTrackingview.typeid = 80 THEN tagTrackingview.info
                                        ELSE tagTrackingview.info
                                    END ))) AS trackValue
                                FROM tagtrackingview
                                    INNER JOIN parttracking ON (tagtrackingview.parttrackingid = parttracking.id)
                                    LEFT OUTER JOIN tagserialview ON (tagtrackingview.tagid = tagserialview.tagid and tagtrackingview.typeid = 40)
                                    GROUP BY tagtrackingview.tagid, parttracking.abbr, parttracking.sortorder
                                ORDER BY parttracking.sortorder) AS partrackinfo
                            GROUP BY partrackinfo.tagid) as tracking on tag.id = tracking.tagid
        WHERE part.id > 0
            AND ((COALESCE(producttree.id,0) IN (?)) OR ((COALESCE(producttree.id,0) LIKE '?')))
            AND (COALESCE(UPPER(tracking.trackvalue),'') like UPPER(CONCAT('%' , '%' , '%')) OR CASE WHEN '%' = CAST('%' AS CHAR(100)) THEN tracking.trackvalue ELSE 1 END IS NUll)
        GROUP BY 1,2,4,5
        ORDER BY product.num"
      Product.find_by_sql([custom_sql, product_tree_id, product_tree_id])
    end
  end  
end
