{
  "sources": {
    "source1": {
      "module": "decisionengine.framework.tests.FailingSourceProxy",
      "parameters": {
        "source_channel": "test_channel",
        "Dataproducts": ["foo"],
        "max_attempts": 1,
      },
      "schedule": 1
     }
   },

   "transforms": {
     "transform1": {
       "module": "decisionengine.framework.tests.TransformNOP",
       "parameters": {}
     }
   },

  "logicengines": {},
  "publishers": {}
}
