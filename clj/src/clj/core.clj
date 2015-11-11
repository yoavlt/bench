(ns clj.core
  (:gen-class main true)
  (:require [compojure.core :refer :all]
            [selmer.parser :refer [render-file]]
            [clojure.data.json :as json]
            [org.httpkit.server :refer [run-server]]))

(def members ["yoavlt" "entotsu" "morishitter"])

(defn render-json [body]
  {:status 200
   :headers {"Content-Type" "application/json"}
   :body (json/write-str body)})

(defn read-json-body [body]
  (json/read-str (slurp body)))

(defroutes totec-clj
  (GET "/:name" [name] (str "Hello " name))
  (GET "/render/html" []
     (render-file "templates/index.html" {:names members}))
  (GET "/render/json" []
     (render-json {:names members}))
  (POST "/post/json" {body :body}
     (when-let [json (read-json-body body)]
       (render-json {:names members}))))

(defn -main []
  (run-server totec-clj {:port 4000}))
