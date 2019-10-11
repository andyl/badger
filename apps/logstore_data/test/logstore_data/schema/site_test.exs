defmodule LogstoreData.Schema.SiteTest do 
  use ExUnit.Case, async: true
  use LogstoreData.DataCase

  alias LogstoreData.Schema.Site

  test "greet the world" do
    assert "hello" == "hello"
  end

  describe "changesets" do
    test "accepts valid input" do
      tmap = %Site{}
      attr = %{name: "asdf"}
      cs = Site.changeset(tmap, attr)
      assert cs.valid?
    end
  end

  describe "inserting records" do
    test "adds a record" do
      tmap = %Site{}
      attr = %{name: "asdf"}
      cset = Site.changeset(tmap, attr)
      assert count(Site) == 0
      assert {:ok, _result} = Repo.insert(cset)
      assert count(Site) == 1
    end
  end

  describe "using Factory" do
    test "building an entity" do
      assert build(:site)
    end

    test "inserting an entity" do
      assert count(Site) == 0
      assert insert(:site)
      assert count(Site) == 1
    end
    
    test "inserting two entities" do
      assert count(Site) == 0
      assert insert(:site)
      assert insert(:site)
      assert count(Site) == 2
    end

    test "uses alternate attrs" do
      altname = "NEWNAME"
      assert count(Site) == 0
      assert trak = insert(:site, %{name: altname})
      assert count(Site) == 1
      assert trak.name == altname
    end
  end

  describe "deleting records" do
    test "all feeds" do
      assert count(Site) == 0
      insert(:site)
      assert count(Site) == 1
      Repo.delete_all(Site)
      assert count(Site) == 0
    end
  end
end
