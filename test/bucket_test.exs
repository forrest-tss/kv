defmodule KV.BucketTest do
  use ExUnit.Case, async: true

  setup do
    bucket = start_supervised!(KV.Bucket)
    %{bucket: bucket}
  end

  test "stores values by key", %{bucket: bucket} do
    assert KV.Bucket.get(bucket, "milk") == nil

    KV.Bucket.put(bucket, "milk", 3)
    assert KV.Bucket.get(bucket, "milk") == 3
  end

  test "keys can be deleted; returns value if key exists",
       %{bucket: bucket} do
    KV.Bucket.put(bucket, "eggs", 2)

    assert KV.Bucket.delete(bucket, "eggs") == 2
    assert KV.Bucket.get(bucket, "eggs") == nil
  end
end
