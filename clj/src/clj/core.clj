(ns clj.core
  (:require [compojure.core :refer :all]
            [selmer.parser :refer [render-file]]
            [org.httpkit.server :refer [run-server]]))

(def members ["yoavlt" "entotsu" "morishitter"])

(defroutes totec-clj
  (GET "/:name" [name] (str "Hello " name))
  (GET "/render/html" []
     (render-file "templates/index.html" {:names members})))

(defn -main []
  (run-server totec-clj {:port 4000}))
